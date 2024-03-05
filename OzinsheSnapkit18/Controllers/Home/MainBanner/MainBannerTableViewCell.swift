//
//  MainBannerTableViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 15.02.2024.
//

import UIKit

class MainBannerTableViewCell: UITableViewCell {

// MARK: - Variables
    var delegate: MovieProtocol?
    var movies: [BannerMovie] = []
    var movie: [Movie] = []
    
    let bannerCollectionView: UICollectionView = {
        
    let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
        layout.itemSize = CGSize(width: 300, height: 220)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainBannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
    
        return collectionView
    }()
 
// MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - setData
    func setData(movies: [BannerMovie]) {
        self.movies = movies
        bannerCollectionView.reloadData()
    }
    
// MARK: - setupUI
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        contentView.addSubview(bannerCollectionView)
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(272)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainBannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! MainBannerCollectionViewCell
        cell.setData(movie: movies[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieDidSelect(movie: movies[indexPath.row].movie)
    }
}
