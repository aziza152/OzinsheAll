//
//  SimilarCollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 24.02.2024.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Add UI Elements
    let  imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        
        return image
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.numberOfLines = 2
        
        return label
    }()
    
    let genreTitleLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.numberOfLines = 2
        
        return label
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        backgroundColor = UIColor(named: "FFFFFF - 111827")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    func setupUI() {

       addSubview(imageView)
       addSubview(titleLabel)
       addSubview(genreTitleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
            make.height.equalTo(164)
    }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
    }
        genreTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
          
        }
    }
    
    //MARK: - setData
    func setData(mainMovie: Movie) {

    }
}
