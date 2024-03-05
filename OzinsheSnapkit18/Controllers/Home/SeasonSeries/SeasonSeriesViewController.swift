//
//  SeasonSeriesViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 24.02.2024.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class SeasonSeriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Variables
    var movie = Movie()
    var seasons: [Season] = []
    var currentSeason = 0
    
    let seriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 8.0, right: 24.0)
        layout.itemSize = CGSize(width: 115, height: 34)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SeasonsSeriesCollectionViewCell.self, forCellWithReuseIdentifier: "SeasonCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor =  UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    let seriesTableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        tableView.register(SeasonSeriesTableViewCell.self, forCellReuseIdentifier: "SeriesCell")
        return tableView
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        
        view.backgroundColor = .systemBackground
        self.title = "Бөлімдер"
        setupUI()
        
        downloadSeasons()
    }
    
    //MARK: - downloadSeasons
    func downloadSeasons() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.GET_SEASONS + String(movie.id), method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
           
            if let data = response.data {
               // resultString = String(data: data, encoding: .utf8)!
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                if let array = json.array {
                    for item in array {
                        let season = Season(json: item)
                        self.seasons.append(season)
                    }
                    self.seriesTableView.reloadData()
                    self.seriesCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            }
        }
    }
    
    //MARK: - setupUI
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubview(seriesCollectionView)
        view.addSubview(seriesTableView)
        
        seriesCollectionView.snp.makeConstraints { make in
            make.top.right.left.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(74)
        }
        
        seriesTableView.snp.makeConstraints { make in
            make.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(seriesCollectionView.snp.bottom)
        }
    }
    
    //MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as! SeasonsSeriesCollectionViewCell
        cell.seasonLabel.text = "\(seasons[indexPath.row].number) сезон"
        
        cell.seasonView.layer.cornerRadius = 8
        if currentSeason == seasons[indexPath.row].number - 1 {
            cell.seasonLabel.textColor = UIColor(displayP3Red: 249/255, green: 250/255, blue: 251/255, alpha: 1)
            cell.seasonView.backgroundColor = UIColor(displayP3Red: 151/255, green: 83/255, blue: 240/255, alpha: 1)
        } else {
            cell.seasonLabel.textColor = UIColor(displayP3Red: 55/255, green: 65/255, blue: 81/255, alpha: 1)
            cell.seasonView.backgroundColor = UIColor(displayP3Red: 243/255, green: 244/255, blue: 246/255, alpha: 1)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currentSeason = seasons[indexPath.row].number - 1
        seriesTableView.reloadData()
        seriesCollectionView.reloadData()
    }
    
    //MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seasons.isEmpty {
            return 0
        }
        return seasons[currentSeason].videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesCell", for: indexPath) as! SeasonSeriesTableViewCell
        cell.seriesLabel.text = "\(seasons[currentSeason].videos[indexPath.row].number)-ші бөлім"
        
        cell.seriesImage.layer.cornerRadius = 12
        
        cell.seriesImage.sd_setImage(with: URL(string: "https://img.youtube.com/vi/\(seasons[currentSeason].videos[indexPath.row].link)/hqdefault.jpg"), completed: nil)
        
        return cell
    }
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 240
}
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let playerVC = MoviePlayerViewController()
    
    playerVC.video_link = seasons[currentSeason].videos[indexPath.row].link
    
    navigationController?.show(playerVC, sender: self)
    navigationItem.title = ""
    self.title = "Бөлімдер"
}
    }

