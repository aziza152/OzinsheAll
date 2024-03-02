//
//  HistoryTableViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 20.02.2024.
//

import UIKit
import SnapKit
import SDWebImage

class HistoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movies: [Movie] = []
    var delegate: MovieProtocol?
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Қарауды жалғастырыңыз"
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
       
        
        return label
    }()
    
    let historyCollectionView = {
    
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 10, right: 24)
        layout.itemSize = CGSize(width: 184, height: 156)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        historyCollectionView.dataSource = self
        historyCollectionView.delegate = self
  setupUI()
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(movies: [Movie]) {
        self.movies = movies
        historyCollectionView.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        contentView.addSubview(titleLabel)
        contentView.addSubview(historyCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalToSuperview()
        }
            historyCollectionView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom)
                make.right.equalToSuperview()
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
       return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
      cell.setData(movie: movies[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: movies[indexPath.row])
    }
    
 }
        


