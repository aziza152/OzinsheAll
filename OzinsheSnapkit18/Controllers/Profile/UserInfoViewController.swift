
//
//  UserInfoViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 02.03.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class UserInfoViewController: UIViewController {
    
    var userID: Int?
    var textToPass: String?
    
    let nameLabel = {
        let label = UILabel()
        label.text = "Сіздің атыңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let nameTextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textAlignment = .left
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return tf
    }()
    
    let line1 = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return line
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let emailTextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font  = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.textAlignment = .left
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.textContentType = .emailAddress
        
        
        return tf
    }()
    
    let line2 = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return line
    }()
    
    let phoneLabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let phoneTextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.textAlignment = .left
        tf.keyboardType = .numbersAndPunctuation
        tf.textContentType = .telephoneNumber
        
        return tf
    }()
    
    let line3 = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return line
    }()
    
    let birthdayLabel = {
        let label = UILabel()
        label.text = "Туылған күні"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let birthdayTextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.textAlignment = .left
        tf.keyboardType = .numberPad
        
        return tf
    }()
    
    let line4 = {
        let line = UIView()
        line.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return line
    }()
    
    lazy var datePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.timeZone = TimeZone.current
        picker.locale = .autoupdatingCurrent
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var toolBar = {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        
        done.setTitleTextAttributes([
            .foregroundColor: UIColor.link
        ], for: .normal)
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        return doneToolbar
    }()
    
    let saveButton = {
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        localizeLanguage()
        setupUI()
        downloadPersonalInfo()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - setupUI
    func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(line1)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(line2)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(line3)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(line4)
        view.addSubview(saveButton)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        line1.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        line3.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(line3.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        birthdayTextField.inputView = datePicker
        birthdayTextField.inputAccessoryView = toolBar
        birthdayTextField.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        line4.snp.makeConstraints { make in
            make.top.equalTo(birthdayTextField.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    func localizeLanguage() {
        navigationItem.title = "PERSONAL_DATA".localized()
        nameLabel.text = "YOUR_NAME".localized()
        phoneLabel.text = "TELEPHONE".localized()
        birthdayLabel.text = "DATE_OF_BIRTH".localized()
        saveButton.setTitle("SAVE_CHANGES".localized(), for: .normal)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        self.birthdayTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func doneButtonAction(){
        birthdayTextField.resignFirstResponder()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK: - downloadPersonalInfo
    func downloadPersonalInfo() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.UPLOAD_USER_INFO, method: .get, headers: headers ).responseData { response in
            SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                let name = json["name"]
                let email = json["user"]["email"]
                let phoneNumber = json["phoneNumber"]
                
                if let birthDate = json["birthDate"].string {
                   let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                if let date = dateFormatter.date(from: birthDate){
                    self.datePicker.date = date
                        dateFormatter.dateFormat = "dd MMMM yyyy"
                    self.birthdayTextField.text = dateFormatter.string(from: date)
                    }
                }
                self.userID = json["id"].int
                self.nameTextField.text = name.stringValue
                self.emailTextField.text = email.stringValue
                self.phoneTextField.text = phoneNumber.stringValue
                
            } else {
                SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
            }
        }
    }
    //MARK: - saveChanges
    @objc func saveChanges() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdate = dateFormatter.string(from: datePicker.date)
        
        let phoneNumber = phoneTextField.text ?? ""
        let name = nameTextField.text ?? ""
        
        
        let parameters = ["name": name, "phoneNumber": phoneNumber, "birthDate": birthdate]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.UPLOAD_USER_INFO, method: .put, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200{
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
//                self.nameTextField.text = json["name"].string
//                self.emailTextField.text = json["user"]["email"].string
//                self.phoneTextField.text = json["phoneNumber"].string
                
            }else{
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode{
                    ErrorString = ErrorString + "\(sCode)"
                }
                ErrorString = ErrorString + "\(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
            
        }
        self.navigationController?.popViewController(animated: true)
    }
}
