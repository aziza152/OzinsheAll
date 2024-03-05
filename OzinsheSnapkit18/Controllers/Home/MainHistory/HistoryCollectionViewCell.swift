//
//  HistoryCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 20.02.2024.
//

import UIKit

class HistoryCollectionViewCell : UICollectionViewCell {
 
    //MARK: - Add UI Elements
    let imageView = {
        let image = UIImageView()
       image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    let titleLabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 12)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.numberOfLines = 3
        
        return label
    }()
    
    let partlabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        
        return label
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        backgroundColor = UIColor(named: "FFFFFF - 111827")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setData
    func setData(movie: Movie) {

       titleLabel.text = movie.name
        partlabel.text = movie.genres.first?.name ?? ""
        imageView.sd_setImage(with: URL(string: movie.poster_link))
    }
    
    //MARK: - setupUI
    func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(partlabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
           // make.width.equalTo(184)
            make.height.equalTo(112)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
    }
        partlabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
}
