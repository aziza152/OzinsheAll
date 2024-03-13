//
//  SearchCollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 02.03.2024.
//
  
    import UIKit
    import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let view = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "F3F4F6-374151")
        
        return view
    }()
    
    let labelText = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "374151-F9FAFB")
        
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setupUI
    func setupUI() {
        contentView.addSubview(view)
        contentView.addSubview(labelText)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        labelText.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
    }
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = isSelected || isHighlighted ? UIColor(named: "D1D5DB-9CA3AF") : UIColor(named: "F3F4F6-374151")
        
    }
}
