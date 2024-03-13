//
//  LanguageViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 02.03.2024.
//

import SnapKit
import UIKit
import Localize_Swift

protocol LanguageProtocol {
    func languageDidChande()
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate {
    
  //  var viewTranslation = CGPoint(x: 0, y: 0)
    var delegate : LanguageProtocol?
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    let backgroundView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
       
    return view
    }()
        
    let lineView = {
        let view = UIView()
            view.backgroundColor = UIColor(named: "D1D5DB-6B7280")
            view.layer.cornerRadius = 2.5
            
    return view
    }()
        
    let titleLabel = {
        let label = UILabel()
            label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
            label.textColor = UIColor(named: "111827-FFFFFF")
            
        return label
    }()
        
    let tableView = {
        let table = UITableView()
            table.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageCell")
            table.backgroundColor = .clear
            table.separatorStyle = .none
            table.showsVerticalScrollIndicator = false
            table.tableFooterView = UIView(frame: .zero)
        return table
    }()
    
    //MARK: - Licecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tapGest()
    
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Add Subviews & Constraints
    func setupUI() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(backgroundView)
        
        titleLabel.text = "LANGUAGE".localized()
      
        backgroundView.addSubview(lineView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(tableView)
        
        backgroundView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(303)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(5)
            make.width.equalTo(64)
        }
        titleLabel.snp.makeConstraints { make in
           // make.top.equalToSuperview().inset(58)
            make.top.equalTo(lineView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        tableView.snp.makeConstraints { make in
          //  make.top.equalToSuperview().offset(98)
            make.top.equalTo(titleLabel.snp.bottom).inset(dynamicValue(for: -12))
            make.right.left.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
//MARK: - Add UITapGestureRecognizer
    func tapGest() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
   
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))! {
            return false
        }
        
        return true
    }
}
    
//MARK: - Extention Table View
extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageTableViewCell
        cell.backgroundColor = .clear
        
        cell.languageLabel.text = languageArray[indexPath.row][0]
        cell.grayView.isHidden = indexPath.row == languageArray.count - 1

        
        if Localize.currentLanguage() == languageArray[indexPath.row][1] {
            cell.checkImage.image = UIImage(named: "Check")
        } else {
            cell.checkImage.image = nil
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChande()
        dismiss(animated: true, completion: nil)
    }
}
