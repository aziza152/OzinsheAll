//
//  MainPageViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class MainPageViewController: UIViewController, MovieProtocol {
    
    
    var mainMovies: [MainMovies] = []
    
   
    let tableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MainBannerTableViewCell.self, forCellReuseIdentifier: "BannerCell")
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainCell")
        tableView.register(GenreAgeTableViewCell.self, forCellReuseIdentifier: "GenreAgeCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        downloadMainBanners()
        addBarImage()
       
    }
    
    func addBarImage() {
        let image = UIImage(named: "logoMainPage")
        let logoImageView = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
        
    }
    
    func setupUI() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        tableView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    func downloadMainBanners() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.MAIN_BANNERS_URL, method: .get, headers: headers).responseData { response in
            
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
                    let movie = MainMovies()
                    movie.cellType = .mainBanner
                    for item in array {
                        let bannerMovie = BannerMovie(json: item)
                        movie.bannerMovie.append(bannerMovie)
                    }
                    self.mainMovies.append(movie)
               
                   self.tableView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                let ErrorString = "CONNECTION_ERROR".localized()
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
           self.downloadHistory()
        }
    }
    func downloadHistory() {
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        SVProgressHUD.show()
        
        AF.request(Urls.USER_HISTORY_URL, method: .get, headers: headers).responseData { response  in SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                if let movies = json.array {
                    let historyMovies = MainMovies()
                    historyMovies.cellType = .userHistory
                    for movie in movies {
                        let movieItem = Movie(json: movie)
                        historyMovies.movies.append(movieItem)
                        
                    }
                    self.mainMovies.append(historyMovies)
                    self.tableView.reloadData()
                }
            } else {
                
            }
        self.downloadMainMovies()
        }
    }
    func downloadMainMovies() {
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        SVProgressHUD.show()
        
        AF.request(Urls.MAIN_MOVIES_URL, method: .get, headers: headers).responseData { response  in SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                if let mainMovies = json.array {
                    for mainMovieItem in mainMovies {
                        let mainMovie = MainMovies(json: mainMovieItem)
                        self.mainMovies.append(mainMovie)
                        self.tableView.reloadData()
                    }
                   self.downloadGenres()
                }
                
            } else {
                
            }
        }
    }
    func downloadGenres() {
        let headers:HTTPHeaders = ["Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        SVProgressHUD.show()
        
        AF.request(Urls.GET_GENRES, method: .get, headers: headers).responseData { response  in SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                
                let json = JSON(response.data!)
                if let genres = json.array {
                    let genres1 = MainMovies()
                    genres1.cellType = .genre
                    for genreJSON in genres {
                        let genreItem = Genre(json: genreJSON)
                        genres1.genres.append(genreItem)
                    }
                    self.mainMovies.insert(genres1, at: 4)
                    self.tableView.reloadData()
                 
                }
                self.downloadCategoryAges()
            } else {
            }
        }
    }
    func downloadCategoryAges() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_AGES, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json.array {
                    let movie = MainMovies()
                    movie.cellType = .ageCategory
                    for item in array {
                        let ageCategory = CategoryAge(json: item)
                        movie.categoryAges.append(ageCategory)
                    }
                        self.mainMovies.append(movie)
                    self.tableView.reloadData()
                    }
                    
                } else {
                }
            }
        }

}
extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainMovie = mainMovies[indexPath.row]
        
        if mainMovie.cellType == .mainBanner{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! MainBannerTableViewCell
            cell.setData(movies: mainMovie.bannerMovie)
            cell.delegate = self
            return cell
        }
        if mainMovie.cellType == .userHistory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
            cell.setData(movies: mainMovie.movies)
           cell.delegate = self
            return cell
        }
        if mainMovies[indexPath.row].cellType == .genre || mainMovies[indexPath.row].cellType == .ageCategory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenreAgeCell", for: indexPath) as! GenreAgeTableViewCell
            cell.setData(movie: mainMovies[indexPath.row])
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        cell.setData(movies: mainMovie)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let mainMovie = mainMovies[indexPath.row]
        if mainMovie.cellType == .mainBanner {
            return 272
        }
        if mainMovie.cellType == .userHistory {
            return 228
        }
        if mainMovie.cellType == .mainMovie {
            return 288
        }
        if mainMovie.cellType == .genre || mainMovie.cellType == .ageCategory {
            return 184
        }
        return 296
    }
    
    func movieDidSelect(movie: Movie) {
        let movieInfoVc = MovieInfoViewController()
        movieInfoVc.movie = movie
        navigationController?.pushViewController(movieInfoVc, animated: true)
    }
    
}
