//
//  MovieInfoViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 21.02.2024.
//

import UIKit
import SnapKit
import UIGradient
import SVProgressHUD
import Alamofire
import SwiftyJSON

class MovieInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movie = Movie()
    var similarMovies:[Movie] = []
    var mainMovie = MainMovies()
    
    //MARK: - Add UI Elements
    let scroll = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    let infoView = {
        let view = UIView()
        view.backgroundColor = .yellow
        
        return view
    }()
    
    lazy var imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var arrowButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "FavoriteButton"), for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        
        return button
    }()
    
    let favoriteLabel = {
        let label = UILabel()
        label.text = "Тізімге қосу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return label
    }()
    
    let playButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.addTarget(self, action: #selector(playMovieTapped), for: .touchUpInside)
        
        return button
    }()
    
    let shareButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shareButton"), for: .normal)
       // button.addTarget(self, action: #selector(shareMovie), for: .touchUpInside)
        
        return button
    }()
    
    let shareLabel = {
        let label = UILabel()
        label.text = "Бөлісу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return label
    }()
    
    let contentView = {
        let view = UIView()
        view.backgroundColor =  UIColor(named: "FFFFFF - 111827")
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        
        return label
    }()
    
    let lineView1 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return view
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF-E5E7EB")
        label.numberOfLines = 4
        
        return label
    }()
    
    lazy var fullDescriptionButton = {
        let button = UIButton()
        button.setTitle("Толығырақ", for: .normal)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(fullDescription), for: .touchUpInside)
        
        return button
    }()
    
    let directorLabel = {
        let label = UILabel()
        label.text = "Режиссер:"
        label.textColor = UIColor(red: 0.294, green: 0.333, blue: 0.388, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        return label
    }()
    
    let producerLabel = {
        let label = UILabel()
        label.text = "Продюсер:"
        label.textColor = UIColor(red: 0.294, green: 0.333, blue: 0.388, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        return label
    }()
    
    let directorNameLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        return label
    }()
    
    let producerNameLabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        return label
    }()
    
    let lineView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return view
    }()
    
    let seasonsLabel = {
        let label = UILabel()
        label.text = "Бөлімдер"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    lazy var seasonsButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Chevron"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.sizeToFit()
        button.setTitleColor(UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
          button.addTarget(self, action: #selector(playMovieTapped), for: .touchUpInside)
       
        return button
    }()
    
    let screenshotsLabel = {
        let label = UILabel()
        label.text = "Скриншоттар"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    let similarMoviesLabel = {
        let label = UILabel()
        label.text = "Ұқсас телехикаялар"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    var descriptionGradientView = {
        let gradient = GradientView()
        gradient.backgroundColor = .clear
        gradient.startColor = UIColor(named: "transparent")!
        gradient.endColor = UIColor(named: "FFFFFF-111827")!
        gradient.startLocation = 0.01
        gradient.endLocation = 1.0
        gradient.horizontalMode = false
        gradient.diagonalMode = false

        return gradient
    }()
    
    let screenshotsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        layout.itemSize = CGSize(width: 184, height: 112)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: "ScreenshotCell")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    let similarCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        layout.itemSize = CGSize(width: 112, height: 208)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SimilarCollectionViewCell.self, forCellWithReuseIdentifier: "SimilarCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        downloadSimilar()
        setData()
        localizeLanguage()
        
        screenshotsCollectionView.delegate = self
        screenshotsCollectionView.dataSource = self
        
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
  
        descriptionGradientView.updateColors()
        descriptionGradientView.updateLocations()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    decriptionNumber()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func decriptionNumber() {
        let maxSize = CGSize(width: descriptionLabel.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
            let textHeight = descriptionLabel.sizeThatFits(maxSize).height
            let lineHeight = descriptionLabel.font.lineHeight
            let maxNumberOfLines = Int(ceil(textHeight / lineHeight))
            
            if descriptionLabel.numberOfLines > 4 {
                descriptionLabel.numberOfLines = 4
            }
            if maxNumberOfLines < 4 {
                fullDescriptionButton.isHidden = true
                 descriptionGradientView.isHidden = true
                directorLabel.snp.remakeConstraints { make in
                    make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
                    make.left.equalToSuperview().inset(24)
                }
                directorNameLabel.snp.remakeConstraints { make in
                    make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
                   make.left.equalToSuperview().inset(113)
                }
            } else {
                fullDescriptionButton.isHidden = false
                 descriptionGradientView.isHidden = false
            }
        }

    func localizeLanguage() {
        favoriteLabel.text = "ADD_FAVORITE".localized()
        shareLabel.text = "SHARE".localized()
        fullDescriptionButton.setTitle("DETAILS".localized(), for: .normal)
        directorLabel.text = "DIRECTOR".localized()
        producerLabel.text = "PRODUCER".localized()
        seasonsLabel.text = "SECTIONS".localized()
        screenshotsLabel.text = "SCREENSHOTS".localized()
        similarMoviesLabel.text = "SIMILAR_SERIES".localized()
        let seasonText = "SEASON".localized()
        let seriesText = "SERIES".localized()
        seasonsButton.setTitle("\(movie.seasonCount) \(seasonText) \(movie.seriesCount) \(seriesText)", for: .normal)
        fullDescriptionButton.setTitle("HIDE".localized(), for: .normal)
    }
    
    //MARK: - setupUI
    func setupUI() {
        view.backgroundColor = .orange
        view.addSubview(scroll)
        scroll.addSubview(infoView)
        infoView.addSubview(imageView)
        infoView.addSubview(arrowButton)
        infoView.addSubview(favoriteButton)
        infoView.addSubview(favoriteLabel)
        infoView.addSubview(playButton)
        infoView.addSubview(shareButton)
        infoView.addSubview(shareLabel)
        infoView.addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(lineView1)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionGradientView)
        contentView.addSubview(fullDescriptionButton)
        contentView.addSubview(directorLabel)
        contentView.addSubview(producerLabel)
        contentView.addSubview(directorNameLabel)
        contentView.addSubview(producerNameLabel)
        contentView.addSubview(lineView2)
        contentView.addSubview(seasonsLabel)
        contentView.addSubview(seasonsButton)
        contentView.addSubview(screenshotsLabel)
        contentView.addSubview(screenshotsCollectionView)
        contentView.addSubview(similarMoviesLabel)
        contentView.addSubview(similarCollectionView)
    }
    
    func setupConstraints() {
        
        scroll.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.right.left.equalToSuperview()
        }
        infoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(scroll)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(363)
        }
        arrowButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(CGSize(width: 95, height: 100))
        }
        favoriteButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(37)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().inset(228)
        }
        favoriteLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton)
            make.top.equalTo(favoriteButton.snp.top).offset(46)
        }
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(37)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().inset(228)
        }
        shareLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shareButton)
            make.top.equalTo(shareButton.snp.top).offset(46)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(198)
            make.size.equalTo(CGSize(width: 132, height: 132))
            make.centerX.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(324)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(24)
        }
        detailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        lineView1.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.top.equalTo(detailLabel.snp.bottom).offset(24)
        }
        descriptionLabel.snp.makeConstraints { make in
           make.top.equalTo(lineView1.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        descriptionGradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.top)
            make.bottom.equalTo(descriptionLabel.snp.bottom)
        }
        fullDescriptionButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        producerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        directorNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(113)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
        }
        producerNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(113)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(directorNameLabel.snp.bottom).offset(8)
        }
        lineView2.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.top.equalTo(producerNameLabel.snp.bottom).offset(24)
        }
        seasonsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(lineView2.snp.bottom).offset(24)
        }
        seasonsButton.snp.makeConstraints { make in
            make.left.equalTo(seasonsLabel.snp.right)
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(seasonsLabel)
        }
        screenshotsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(seasonsLabel.snp.bottom).offset(32)
        }
        screenshotsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(screenshotsLabel.snp.bottom).offset(16)
            make.height.equalTo(112)
        }
        similarMoviesLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotsCollectionView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        similarCollectionView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(similarMoviesLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(45)
            make.height.equalTo(220)
        }
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - addToFavorite
    @objc func addToFavorite() {
        var method = HTTPMethod.post
        if movie.favorite {
            method = .delete
        }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        let parameters: [String: Any] = [
            "movieId": movie.id]
        SVProgressHUD.show()
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            if (200..<300).contains (response.response?.statusCode ?? -1) {
                self.movie.favorite.toggle()
               self.setData()
            } else {
                SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
            }
        }
    }
    @objc func playMovieTapped() {
        if movie.movieType == "MOVIE" {
            let playerVC = MoviePlayerViewController()
            playerVC.video_link = movie.video_link
           // playerVC.movie = movie
            navigationController?.show(playerVC, sender: self)
            navigationItem.title = ""
        } else {
            let seasonsVC = SeasonSeriesViewController()
            
            seasonsVC.movie = movie
            
            navigationController?.show(seasonsVC, sender: self)
            navigationItem.title = ""
        }
    }
    @objc func fullDescription() {
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
            fullDescriptionButton.setTitle("Толығырақ", for: .normal)
            descriptionGradientView.isHidden = false
        } else {
            descriptionLabel.numberOfLines = 30
            fullDescriptionButton.setTitle("Жасыру", for: .normal)
            descriptionGradientView.isHidden = true
        }
    }
    
    //MARK: - setData
        func setData() {
            imageView.sd_setImage(with: URL(string: movie.poster_link), completed: nil)
            nameLabel.text = movie.name
            detailLabel.text = "\(movie.year)"
            for item in movie.genres {
                detailLabel.text = detailLabel.text! + " • " + item.name
            }
            descriptionLabel.text = movie.description
            directorNameLabel.text = movie.director
            producerNameLabel.text = movie.producer
            
            if movie.movieType == "MOVIE" {
                seasonsLabel.isHidden = true
                seasonsButton.isHidden = true
                
                screenshotsLabel.snp.remakeConstraints { make in
                    make.left.equalToSuperview().inset(24)
                    make.top.equalTo(lineView2.snp.bottom).offset(24)
                }
            } else {
                seasonsButton.setTitle("\(movie.seasonCount) сезон, \(movie.seriesCount) серия", for: .normal)
            }
            if descriptionLabel.numberOfLines < 5 {
                fullDescriptionButton.isHidden = true
            }
            if movie.favorite {
                favoriteButton.setImage(UIImage(named: "favoriteSelected"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "FavoriteButton"), for: .normal)
            }
        }
    
    //MARK: - downloadSimilar
    func downloadSimilar() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_SIMILAR + String(movie.id), method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let movie = Movie(json: item)
                        self.similarMovies.append(movie)
                    }
                    self.similarCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    //MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.similarCollectionView {
            return similarMovies.count
        }
        return movie.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.similarCollectionView {
            let similarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCell", for: indexPath) as! SimilarCollectionViewCell
            
            similarCell.imageView.sd_setImage(with: URL(string: similarMovies[indexPath.row].poster_link))
            similarCell.titleLabel.text = similarMovies[indexPath.row].name
            
            return similarCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) as! ScreenshotCollectionViewCell
        
        cell.imageView.sd_setImage(with: URL(string: movie.screenshots[indexPath.row].link))
        return cell
    }
}
