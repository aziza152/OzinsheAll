//
//  MovieTableViewCell.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 29.02.2024.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    let posterImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        
        return image
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        return label
    }()
    
    let playView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.93, blue: 1, alpha: 1)
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let playImage = {
        let image = UIImageView()
        image.image = UIImage(named: "playImage")
        
        return image
    }()
    
    let playLabelText = {
        let label = UILabel()
        label.text = "Қарау"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1)
        
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        return view
    }()

// MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setData(movie: Movie) {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link), completed: nil)
        titleLabel.text = movie.name
        detailLabel.text = "\(movie.year) • \(movie.producer) • \(movie.seriesCount) серия"
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(playView)
        playView.addSubview(playImage)
        playView.addSubview(playLabelText)
        contentView.addSubview(lineView)

        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.top.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(titleLabel)
        }

        playView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(detailLabel.snp.bottom).offset(24)
            make.height.equalTo(26)
            make.right.equalTo(playLabelText.snp.right).offset(12)
        }
        playImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }
        playLabelText.snp.makeConstraints { make in
            make.centerY.equalTo(playView)
            make.left.equalTo(playImage.snp.right).offset(4)
        }
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
