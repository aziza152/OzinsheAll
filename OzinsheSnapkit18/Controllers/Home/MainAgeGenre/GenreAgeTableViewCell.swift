//
//  GenreAgeTableViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 21.02.2024.
//

import UIKit

class GenreAgeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var mainMovie = MainMovies()
    var delegate: MovieProtocol?
    var movies: [Movie] = []
    
    //MARK: - Add UI Elements
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let genreAgeCollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 10, right: 24)
        layout.itemSize = CGSize(width: 184, height: 112)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreAgeCollectionViewCell.self, forCellWithReuseIdentifier: "GenreAgeCell")
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        genreAgeCollectionView.dataSource = self
        genreAgeCollectionView.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - setData
    func setData(movie: MainMovies) {
        self.mainMovie = movie
        titleLabel.text = mainMovie.categoryName
        genreAgeCollectionView.reloadData()
        if !movie.categoryAges.isEmpty {
            titleLabel.text = "Жасына сәйкес"
        } else {
            titleLabel.text = "Жанрды таңдаңыз"
        }
    }

// MARK: - setupUI
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreAgeCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        genreAgeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainMovie.cellType == .ageCategory {
        return mainMovie.categoryAges.count
    }
    return mainMovie.genres.count
}
    
    //MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreAgeCell", for: indexPath) as! GenreAgeCollectionViewCell
        
        
        if mainMovie.cellType == .ageCategory {
            cell.imageView.sd_setImage(with: URL(string: mainMovie.categoryAges[indexPath.row].link))
            
            cell.titleLabel.text = mainMovie.categoryAges[indexPath.row].name
        } else {
            cell.imageView.sd_setImage(with: URL(string: mainMovie.genres[indexPath.row].link))
            cell.titleLabel.text = mainMovie.genres[indexPath.row].name
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if mainMovie.cellType == .ageCategory {
            delegate?.ageDidSelect(id: mainMovie.categoryAges[indexPath.row].id, name: mainMovie.categoryAges[indexPath.row].name)
        } else {
            delegate?.genreDidSelect(id: mainMovie.genres[indexPath.row].id, name: mainMovie.genres[indexPath.row].name)
        }
    }

    }

