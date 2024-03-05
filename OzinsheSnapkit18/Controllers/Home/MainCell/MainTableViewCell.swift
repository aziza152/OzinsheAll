//
//  MainTableViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 15.02.2024.
//

import UIKit


class MainTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

// MARK: - Variables
    var mainMovie = MainMovies()
    var movies: [Movie] = []
    var delegate: MovieProtocol?
    
//MARK: - Add UI Elements
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        
        return label
    }()
    let allButton = {
        let button = UIButton()
        button.setTitle("Барлығы", for: .normal)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 14)
    //    button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        return button
    }()
    
    let mainCollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
      layout.itemSize = CGSize(width: 112, height: 220)
       
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCell")
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
   
// MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - setData
    func setData(movies: MainMovies) {
        self.mainMovie = movies
        titleLabel.text = mainMovie.categoryName
        mainCollectionView.reloadData()
    }
    
// MARK: - setupUI
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainCollectionView)
        contentView.addSubview(allButton)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.top.equalToSuperview()
        }
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        allButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.top.equalToSuperview()
        }
    }
    
    //MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCollectionViewCell
        cell.setData(mainMovie: mainMovie.movies[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
    }
    
}
