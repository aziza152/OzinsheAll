//
//  SearchCollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 02.03.2024.
//
  
    import UIKit
    import SnapKit

    class SearchCollectionViewCell: UICollectionViewCell {
        
        //MARK: - Add UI Elements
        let backView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "F3F4F6 - 374151")
            view.layer.cornerRadius = 8
            return view
        }()
        
        let label: UILabel = {
            let labelCell = UILabel()
            labelCell.text = ""
            labelCell.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
            labelCell.textColor = UIColor(named: "374151 - 1C2431")
            
            return labelCell
        }()
        
        //MARK: - Initialization
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            backgroundColor = UIColor(named: "FFFFFF - 111827")
            layer.cornerRadius = 8
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        //MARK: - setupUI
        func setupUI() {
            contentView.addSubview(backView)
            backView.addSubview(label)
            
            backView.snp.makeConstraints { make in
                make.edges.equalTo(contentView.safeAreaLayoutGuide)
            }
        
            label.snp.makeConstraints { make in
                make.right.left.equalToSuperview().inset(16)
                make.bottom.top.equalToSuperview()
                make.height.equalTo(34)
        }
      }
    }
