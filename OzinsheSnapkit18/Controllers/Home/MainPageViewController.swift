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

class MainPageViewController: UIViewController {
    
    var mainMovies: [MainMovies] = []
    
    let tableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MainBannerTableViewCell.self, forCellReuseIdentifier: "BannerCell")
        
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
        tableView.backgroundColor = .green
        
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
                var ErrorString = "CONNECTION_ERROR".localized()
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
          //  self.downloadUserHistory()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! MainBannerTableViewCell
            
        let mainMovie = mainMovies[indexPath.row]
        
        cell.setData(movies: mainMovie.bannerMovie)

            return cell
        }

    }


