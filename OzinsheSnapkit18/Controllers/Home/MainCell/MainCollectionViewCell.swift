//
//  MainCollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 21.02.2024.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
   
    //MARK: - Add UI Elements
    let imageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
       image.clipsToBounds = true
        
        return image
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        
        return label
    }()
    let lastPartLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
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
    
    //MARK: - setupUI
    func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(lastPartLabel)
        
        imageView.snp.makeConstraints { make in
            //  make.top.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(164)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.equalToSuperview()
        }
        lastPartLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
        
    }
    
    //MARK: - setData
    func setData(mainMovie: Movie) {
        titleLabel.text = mainMovie.name
        lastPartLabel.text = mainMovie.genres.first?.name ?? ""
        imageView.sd_setImage(with: URL(string: mainMovie.poster_link))
        
    }

}
