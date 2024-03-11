//
//  SignUpViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import UIKit
import SnapKit
import SVProgressHUD
import Localize_Swift
import SwiftyJSON
import Alamofire


class SignUpViewController: UIViewController {
    
    var signUpButtonTopConstraint: Constraint?
    
    let welcomeLabel = {
        let label = UILabel()
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let signUpLabel = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.50, alpha: 1.00)
        
        return label
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let emailTextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Сіздің email"
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
       return textField
    }()
    
    let emailImage = {
        let image = UIImageView()
        image.image = UIImage(named: "email")
        
        return image
    }()

    let passwordLabel = {
        let label = UILabel()
        label.text = "Құпиясөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let passwordTextField = {
        let textfield = TextFieldWithPadding()
        textfield.placeholder = "Сіздің құпия сөзіңіз"
        textfield.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textfield.textColor = UIColor(named: "111827 - FFFFFF")
        textfield.isSecureTextEntry = true
        textfield.layer.cornerRadius = 12
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        
       return textfield
    }()

    let passwordImage = {
        let image = UIImageView()
        image.image = UIImage(named: "password")
        
        return image
    }()
    
    lazy var showPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        
        return button
    }()
    
    let repeatPasswordLabel = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let repeatPasswordTextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        
       return textField
    }()

    let repeatPasswordImage = {
        let image = UIImageView()
        image.image = UIImage(named: "password")
        
        return image
    }()
    
    lazy var repeatShowPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(repeatShowPassTapped), for: .touchUpInside)
        
        return button
    }()
    
    let alreadyExistsLabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Мұндай email-ы бар пайдаланушы тіркелген"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(red: 0.49, green: 0.18, blue: 0.99, alpha: 1.00)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    var registerView: UIStackView = {
        let stackView = UIStackView()
    let accountLabel2 = {
        let label = UILabel()
        label.text = "Сізде аккаунт бар ма?  "
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.50, alpha: 1.00)
        label.textAlignment = .right
        
        return label
    }()
    
    let signInButton = {
        let button = UIButton()
        button.setTitle("  Kіру", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        return button
    }()

        stackView.addArrangedSubview(accountLabel2)
        stackView.addArrangedSubview(signInButton)
        
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        signUpTapped()
        hideKeyboardWhenTappedAround()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    @objc func editingDidbegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        view.layoutIfNeeded()
    }

    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 229/255, green: 245/255, blue: 240/255, alpha: 1.00).cgColor
    }
    func hideKeyboardWhenTappedAround() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
            view.endEditing(true)
    }
    
    @objc func showPasswordTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func repeatShowPassTapped() {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    @objc func signInTapped() {
        let signInViewController = SignInViewController()
       self.navigationController?.popViewController(animated: true)
        navigationItem.title = ""
    }
    
  
    @objc func signUpTapped() {
        let signUpEmail = emailTextField.text!
        let signUpPassword = passwordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        if signUpPassword != repeatPassword {
            DispatchQueue.main.async {
                SVProgressHUD.showError(withStatus: "Пароли должны совпадать!")
            }
            return
        }
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        
        if !isValidEmail(signUpEmail) {
            alreadyExistsLabel.isHidden = true
            emailTextField.layer.borderWidth = 1
            view.layoutIfNeeded()
                return
        }
    
        SVProgressHUD.show()
        let parameters = ["email": signUpEmail, "password": signUpPassword]
            
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
                
        SVProgressHUD.dismiss()
        var resultString = ""
        if let data = response.data {
          resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
            }
                
                if response.response?.statusCode == 200 {
                    let json = JSON(response.data!)
                    print("JSON: \(json)")
                    
                    if let token = json["accessToken"].string {
                        Storage.sharedInstance.accessToken = token
                        UserDefaults.standard.set(token, forKey: "accessToken")
                        self.startApp()
                    }
                } else {
                    if response.response?.statusCode == 400 {
                        DispatchQueue.main.async {
                        self.alreadyExistsLabel.isHidden = false
                        self.signUpButtonTopConstraint?.update(offset: 40 + self.alreadyExistsLabel.frame.size.height + 10) 
                            UIView.animate(withDuration: 0.3) {
                                self.view.layoutIfNeeded()
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                          //  self.alreadyExistsLabel.isHidden = true
                        }
                        let ErrorString = "CONNECTION_ERROR".localized()
                        SVProgressHUD.showError(withStatus: "\(ErrorString)")
                    }
                }
            }
        }
    
    func startApp() {
        let tabViewController = TabBarController()
        tabViewController.modalPresentationStyle = .fullScreen
        self.present(tabViewController, animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")

        view.addSubview(welcomeLabel)
        view.addSubview(signUpLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailImage)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordImage)
        view.addSubview(showPasswordButton)
        view.addSubview(repeatPasswordLabel)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(repeatPasswordImage)
        view.addSubview(repeatShowPasswordButton)
        view.addSubview(signUpButton)
        view.addSubview(registerView)
        view.addSubview(alreadyExistsLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).inset(0)
            make.left.equalToSuperview().inset(24)
        }
      
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        emailImage.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.leading).inset(16)
        }
         
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(13)
            make.left.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        passwordImage.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.leading.equalTo(passwordTextField.snp.leading).inset(16)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField).inset(0)
            make.height.equalTo(56)
            make.width.equalTo(36)
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(13)
            make.left.equalToSuperview().inset(24)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        repeatPasswordImage.snp.makeConstraints { make in
            make.centerY.equalTo(repeatPasswordTextField)
            make.leading.equalTo(repeatPasswordTextField.snp.leading).inset(16)
        }
  
        repeatShowPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(repeatPasswordTextField)
            make.right.equalTo(repeatPasswordTextField).inset(0)
            make.height.equalTo(56)
            make.width.equalTo(36)
        }
        signUpButton.snp.makeConstraints { make in
            self.signUpButtonTopConstraint = make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(40).constraint
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        registerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(24)
        }
        alreadyExistsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(31)
            make.height.equalTo(22)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == passwordTextField {
            passwordTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == repeatPasswordTextField {
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == passwordTextField {
            passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == repeatPasswordTextField {
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        }
    }
}
