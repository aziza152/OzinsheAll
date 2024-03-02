//
//  ScreenshotCollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 24.02.2024.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.bottom.equalToSuperview()
            
        }
        
    }
    
}
