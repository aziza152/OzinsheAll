//
//  CollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 24.02.2024.
//

import UIKit

class SeasonsSeriesCollectionViewCell: UICollectionViewCell {
    
    let seasonView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.592, green: 0.325, blue: 0.941, alpha: 1)
        view.layer.cornerRadius = 8
        
       return view
    }()
    
    let seasonLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = .white
        
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
    
    func setupUI() {
        
        contentView.addSubview(seasonView)
        contentView.addSubview(seasonLabel)
        
        seasonView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        seasonLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }
}
