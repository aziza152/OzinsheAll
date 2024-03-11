//
//  SearchViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
class SearchViewController: UIViewController {
    
    var categories: [Category] = []
    var movie: [Movie] = []
    
    let searchTextField = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Іздеу"
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(named: "E4EBEF-1C2431")?.cgColor
        tf.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        tf.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tf.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.addTarget(self, action: #selector(editingDiDBegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        tf.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let clearButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Cross"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let searchButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Search2"), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "F3F4F6-374151")
        
        return button
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.text = "Санаттар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize.width = 100
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        layout.itemSize = UIScreen.main.bounds.size
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: false)
        cv.contentInsetAdjustmentBehavior = .never
        cv.isScrollEnabled = true
        cv.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCell")
        cv.contentInsetAdjustmentBehavior = .automatic
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        setupUI()
        downloadCategories()
        hideKeyboardWhenTappedAround()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localizeLanguage()
    }
    //MARK: - setupUI
    func setupUI() {
        view.addSubview(searchTextField)
        view.addSubview(clearButton)
        view.addSubview(searchButton)
        view.addSubview(categoryLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        clearButton.snp.makeConstraints { make in
            make.right.top.bottom.equalTo(searchTextField)
            make.height.width.equalTo(56)
        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField)
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(searchTextField.snp.right).offset(16)
            make.height.width.equalTo(56)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(35)
            make.left.equalToSuperview().inset(24)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(400)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func localizeLanguage() {
        searchTextField.placeholder = "SEARCH".localized()
        categoryLabel.text = "CATEGORIES".localized()
        navigationItem.title = "SEARCH".localized()
    }
    //MARK: - downloadMovies
    func downloadMovies() {
        
        guard let text = searchTextField.text else { return }
        
        if text.isEmpty {
            categoryLabel.text = "Санаттар"
            searchButton.setImage(UIImage(named: "Search2")?.withRenderingMode(.alwaysOriginal), for: .normal)
            searchButton.tintColor = UIColor(named: "TextGray2")
            collectionView.isHidden = false
            tableView.isHidden = true
            movie.removeAll()
            tableView.reloadData()
            clearButton.isHidden = true
            return
        } else {
            categoryLabel.text = "SEARCH_RESULTS".localized()
            searchButton.setImage(UIImage(named: "Search2")?.withRenderingMode(.alwaysTemplate), for: .normal)
            searchButton.tintColor = UIColor(named: "LightPurple")
            collectionView.isHidden = true
            tableView.isHidden = false
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(categoryLabel.snp.bottom).offset(10)
                make.bottom.equalTo(view.safeAreaLayoutGuide)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            clearButton.isHidden = false
            
            SVProgressHUD.show()
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
            
            let parameters = ["search": text]
            
            AF.request(
                Urls.SEARCH_MOVIES_URL,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: headers
            ).responseData { response in
                SVProgressHUD.dismiss()
                
                if response.response?.statusCode == 200 {
                    // Success
                    let json = JSON(response.data!)
                    
                    if let items = json.array {
                        self.movie.removeAll()
                        self.tableView.reloadData()
                        
                        for item in items {
                            let movie = Movie(json: item)
                            
                            self.movie.append(movie)
                        }
                        self.tableView.reloadData()
                    }
                } else {
                    var resultString = ""
                    if let data = response.data {
                        resultString = String(data: data, encoding: .utf8)!
                    }
                    SVProgressHUD.showError(withStatus: resultString)
                }
            }
        }
    }
    //MARK: - downloadCategories
    func downloadCategories() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request("http://api.ozinshe.com/core/V1/categories", method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                
                let json = JSON(response.data!)
                
                if let items = json.array {
                    for item in items {
                        let category = Category(json: item)
                        
                        self.categories.append(category)
                    }
                    
                    self.collectionView.reloadData()
                }
            } else {
                var resultString = ""
                
                if let data = response.data {
                    resultString = String(data: data, encoding: .utf8)!
                }
                SVProgressHUD.showError(withStatus: resultString)
            }
        }
    }
    
    @objc func clearButtonTapped(_ sender: Any) {
        searchTextField.text = ""
        clearButton.isHidden = true
        downloadMovies()
    }
    
    @objc func editingDiDBegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
    }
    
    @objc func editingChanged(_ sender: TextFieldWithPadding) {
        guard let text = sender.text else { return }
        clearButton.isHidden = text.isEmpty
        downloadMovies()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource,
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCollectionViewCell
        cell.labelText.text = categories[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let categoryVC = CategoryViewController()
        
        categoryVC.categoryId = categories[indexPath.row].id
        categoryVC.categoryName = categories[indexPath.row].name
        
        navigationController?.show(categoryVC, sender: self)
    }
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.setData(movie: movie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieInfoVC = MovieInfoViewController()
        movieInfoVC.movie = movie[indexPath.row]
        navigationController?.pushViewController(movieInfoVC, animated: true)
    }
}
