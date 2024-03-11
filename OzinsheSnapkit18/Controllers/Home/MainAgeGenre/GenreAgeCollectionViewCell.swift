//
//  GenreAgeCollectionViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 22.02.2024.
//

import UIKit
import SnapKit

class GenreAgeCollectionViewCell: UICollectionViewCell {

    //MARK: - Add UI Elements
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12

        return image
    }()

    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor(named: "FFFFFF - 111827")
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setupUI
    func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    func setData(movie: Movie) {
    }
}
