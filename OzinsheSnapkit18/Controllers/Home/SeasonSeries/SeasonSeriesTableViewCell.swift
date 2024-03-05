//
//  SeasonSeriesTableViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 24.02.2024.
//

import UIKit

class SeasonSeriesTableViewCell: UITableViewCell {

    //MARK: - Add UI Elements
    let seriesLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let seriesImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        return image
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return view
    }()
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubview(seriesImage)
        contentView.addSubview(seriesLabel)
        contentView.addSubview(lineView)
        
        seriesLabel.snp.makeConstraints { make in
            make.top.equalTo(seriesImage.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(24)
        }
        
        seriesImage.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(178)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(seriesLabel.snp.bottom).offset(16)
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
}

