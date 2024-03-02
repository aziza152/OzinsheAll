//
//  OnboardingViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 11.02.2024.
//

import UIKit

class OnboardingViewCell: UICollectionViewCell {
    
    
    let foto: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    let welcomeLabel = {
        let label = UILabel()
        label.font = UIFont (name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.textAlignment = .center
        
        return label
    }()
    
    let infoLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var nextButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.setTitle("Әрі қарай", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    let skipButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "FFFFFF - 111827")
        button.setTitle("Өткізу", for: .normal)
        button.setTitleColor(UIColor(named: "111827 - FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 22
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "SFProDisplay-Regular", size: 14)!,
            .foregroundColor: UIColor(red: 0.42, green: 0.447, blue: 0.502, alpha: 1),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.5, range: NSRange(location: 0, length: attributedString.length))
        infoLabel.attributedText = attributedString
    }

        func setupUI() {
            addSubview(foto)
            addSubview(welcomeLabel)
            addSubview(infoLabel)
            addSubview(nextButton)
            addSubview(skipButton)
           

foto.snp.makeConstraints { make in
    make.top.right.left.equalToSuperview()
    make.height.equalToSuperview().multipliedBy(0.6)
}

welcomeLabel.snp.makeConstraints { make in
    make.left.right.equalToSuperview().inset(40)
    make.bottom.equalTo(foto.snp.bottom).inset(2)
}

infoLabel.snp.makeConstraints { make in
    make.left.right.equalToSuperview().inset(32)
    make.top.equalTo(welcomeLabel.snp.bottom).offset(24)
}

nextButton.snp.makeConstraints { make in
    make.left.right.equalToSuperview().inset(24)
    make.bottom.equalTo(safeAreaLayoutGuide).inset(38)
    make.height.equalTo(56)
}

skipButton.snp.makeConstraints { make in
    make.top.equalToSuperview().offset(60)
    make.right.equalToSuperview().inset(24)
}
}
}
