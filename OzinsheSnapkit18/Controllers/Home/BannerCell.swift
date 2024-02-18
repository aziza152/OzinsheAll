//
//  BannerCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 16.02.2024.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

class BannerCell: UICollectionViewCell {
    
    let identifier = "BannerCell"
    
     let titleLabel = {
        let label = UILabel()
         label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
         label.textColor = UIColor(named: "111827 - FFFFFF")
         
         return label
    }()
    
    let descriptionLabel = {
       let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        return label
    }()
    
    let imageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bannerImage")
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        
        return image
    }()
    
    let categoryView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "FFFFFF - 111827")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        backgroundColor = UIColor(named: "FFFFFF - 111827")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(movie: BannerMovie) {
        
        if let categoryName = movie.movie.categories.first?.name {
            categoryLabel.text = categoryName
        }
        
        titleLabel.text = movie.movie.name
        descriptionLabel.text = movie.movie.description
        categoryLabel.text = movie.movie.categories.first?.name
        imageView.sd_setImage(with: URL(string: movie.link)!)
    }
    
    func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(imageView)
        addSubview(categoryView)
        addSubview(categoryLabel)
        categoryView.addSubview(categoryLabel)
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(164)
            make.width.equalTo(300)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.top)
            make.bottom.equalTo(categoryView.snp.bottom)
            make.left.right.equalToSuperview().inset(8)
        }
    }
}
