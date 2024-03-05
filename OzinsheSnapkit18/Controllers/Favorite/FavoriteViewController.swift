//
//  FavoriteViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 25.02.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class FavoriteViewController: UIViewController {
    
    //MARK: - Variables
    var favorite:[Movie] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        downloadFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
    }
    
    //MARK: - setupUI
    func setupUI() {
        navigationItem.title = "FAVORITE_NAVIGATION".localized()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: - downloadFavorites
    func downloadFavorites() {
        self.favorite.removeAll()
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        AF.request(Urls.FAVORITE_URL, method: .get, headers: headers).responseData {
            response in
            
            SVProgressHUD.dismiss()
           
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let movie = Movie(json: item)
                        self.favorite.append(movie)
                    }
                    self.tableView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + "\(sCode)"
                }
            }
        }
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieinfoVC = MovieInfoViewController()
        
        movieinfoVC.movie = favorite[indexPath.row]
        
        navigationController?.show(movieinfoVC, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.setData(movie: favorite[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
}
