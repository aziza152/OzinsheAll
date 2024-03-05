//
//  ProfileViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import UIKit
import SnapKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
    func languageDidChande() {
        configureViews()
    }
    

    //MARK: - Add UI Elements
    let logoutButton = {
    let button = UIBarButtonItem()
        button.image = UIImage(named: "Logout")
        button.tintColor = .red
        button.action = #selector(logout)
      //  let logoutButton = UIBarButtonItem(image: UIImage(named: "Logout"), style: .plain, target: self, action: #selector(logout))

        return button
    }()
    
    let avatarImage = {
    let image = UIImageView()
        image.image = UIImage(named: "Avatar")
            
        return image
    }()
        
    let profileLabel = {
    let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
            
        return label
    }()
        
    let emailLabel = {
    let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
            
        return label
    }()
        
    let backgroundView = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "#F9FAFB-#111827") //UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
            
        return view
    }()
        
    let personalButton = {
    let button = UIButton()
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(editPersonalData), for: .touchUpInside)
            
        return button
    }()
        
    let editLabel = {
    let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
            
        return label
    }()
        
    let chevron1 = {
    let image = UIImageView()
        image.image = UIImage(named: "Chevron")
        
        return image
    }()
        
    let line1 = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return view
    }()
        
    let changePasswordButton = {
    let button = UIButton()
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openChangePassword), for: .touchUpInside)
            
        return button
    }()
        
    let chevron2 = {
    let image = UIImageView()
        image.image = UIImage(named: "Chevron")
            
            return image
    }()
        
    let line2 = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
            
        return view
    }()
        
    let languageButton = {
    let button = UIButton()
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openLanguageVC), for: .touchUpInside)
            
        return button
    }()
        
    let languageLabel = {
    let label = UILabel()
        label.text = "Қазақша"
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
            
        return label
    }()
        
    let chevron3 = {
    let image = UIImageView()
        image.image = UIImage(named: "Chevron")
            
        return image
    }()
        
    let line3 = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
            
        return view
    }()
    
    let darkModeLabel = {
    let label = UILabel()
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
            
        return label
    }()
    
    let darkModeSwitch = {
    let sw = UISwitch()
        sw.onTintColor = UIColor(named: "B376F7")
        sw.addTarget(self, action: #selector(darkMode), for: .valueChanged)
            
        return sw
    }()

//MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF-1C2431")
      //  self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       // navigationItem.title = "Профиль"
//        navigationItem.rightBarButtonItem = logoutButton
       // logoutButton.target = self
        
        setupUI()
        configureViews()
        loadUserEmail()
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
  
    
    
//MARK: - setupUI
    func setupUI() {
        
        navigationItem.rightBarButtonItem = logoutButton
        view.addSubview(avatarImage)
        view.addSubview(profileLabel)
        view.addSubview(emailLabel)
        view.addSubview(backgroundView)
            
        backgroundView.addSubview(personalButton)
        backgroundView.addSubview(editLabel)
        backgroundView.addSubview(chevron1)
        backgroundView.addSubview(line1)
        backgroundView.addSubview(changePasswordButton)
        backgroundView.addSubview(chevron2)
        backgroundView.addSubview(line2)
        backgroundView.addSubview(languageButton)
        backgroundView.addSubview(languageLabel)
        backgroundView.addSubview(chevron3)
        backgroundView.addSubview(line3)
        backgroundView.addSubview(darkModeLabel)
        backgroundView.addSubview(darkModeSwitch)
            
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(104)
        }
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        personalButton.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        editLabel.snp.makeConstraints { make in
            make.centerY.equalTo(personalButton)
            make.right.equalTo(personalButton).inset(24)
        }
        chevron1.snp.makeConstraints { make in
            make.centerY.equalTo(personalButton)
            make.right.equalTo(personalButton)
        }
        line1.snp.makeConstraints { make in
            make.top.equalTo(personalButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        chevron2.snp.makeConstraints { make in
            make.centerY.equalTo(changePasswordButton)
            make.right.equalTo(changePasswordButton)
        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        languageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
            make.right.equalTo(languageButton).inset(24)
        }
        chevron3.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
            make.right.equalTo(languageButton)
        }
        line3.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        darkModeLabel.snp.makeConstraints { make in
            make.top.equalTo(line3.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        darkModeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeLabel)
            make.right.equalTo(darkModeLabel)
            make.width.equalTo(52)
            make.height.equalTo(32)
        }
    }

//MARK: - configureViews
        func configureViews() {
    
        if UserDefaults.standard.string(forKey: "isDarkMode") == "Dark" {
            darkModeSwitch.setOn(true, animated: false)
        } else {
            darkModeSwitch.setOn(false, animated: false)
        }
        profileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for:.normal)
        personalButton.setTitle("PERSONAL_DATA".localized(), for: .normal)
        changePasswordButton.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        darkModeLabel.text = "DARK_MODE".localized()
        editLabel.text = "EDIT".localized()
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
        }
    }
        @objc func logout() {
            let logout = LogoutViewController()
            logout.modalPresentationStyle = .overFullScreen
            present(logout, animated: true)
        }
        @objc func editPersonalData() {
            let change = UserInfoViewController()
            navigationController?.show(change, sender: self)
            tabBarController?.tabBar.isHidden = true
        }
        @objc func openChangePassword() {
            let changePassword = ChangePasswordViewController()
            navigationController?.show(changePassword, sender: self)
            tabBarController?.tabBar.isHidden = true
            
        }
        @objc func openLanguageVC() {
            let languageVC = LanguageViewController()
            
            languageVC.modalPresentationStyle = .overFullScreen
            languageVC.delegate = self
            present(languageVC, animated: true, completion: nil)
        }
//        func languageDidChange() {
//            configureViews()
//        }
        
        @objc func darkMode(_ sender: UISwitch) {
            let defaults = UserDefaults.standard
            if let window = view.window {
                if darkModeSwitch.isOn {
                    window.overrideUserInterfaceStyle = .dark
                    defaults.set("Dark", forKey: "isDarkMode")
                } else {
                    window.overrideUserInterfaceStyle = .light
                    defaults.set("Light", forKey: "isDarkMode")
                }
            }
        }
    func loadUserEmail() {
        if let userEmail = UserDefaults.standard.string(forKey: "userEmail") {
            emailLabel.text = userEmail
        }
    }
    }

