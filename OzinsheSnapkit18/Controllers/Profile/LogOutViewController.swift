//
//  LogOutViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 02.03.2024.
//

import SnapKit

class LogoutViewController: UIViewController, UIGestureRecognizerDelegate {
    
  //  let blurEffect = UIBlurEffect(style: .dark)
//    let blurView = UIVisualEffectView(effect: nil)
    
    let backgroundView = {
        let view = UIView()
      //  view.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    let line = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-6B7280")
        view.layer.cornerRadius = 2.5
        
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Шығу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.text = "Сіз шынымен аккаунтыныздан "
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let yesButton = {
        let button = UIButton()
        button.setTitle("Иә, шығу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
       // button.backgroundColor = UIColor(named: "7E2DFC")
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return button
    }()
    
    let noButton = {
        let button = UIButton()
        button.setTitle("Жоқ", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.setTitleColor(UIColor(named: "5415C6-B376F7"), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        localizeLanguage()
        setupUI()
    }
    
    func localizeLanguage() {
        
        titleLabel.text = "EXIT".localized()
        subTitleLabel.text = "CONFIRM_EXIT_FROM_ACCOUNT".localized()
        yesButton.setTitle("YES_EXIT".localized(), for: .normal)
        noButton.setTitle("NO".localized(), for: .normal)
    }
    
    func setupUI() {
        
       // blurView.effect = blurEffect
      //  blurView.frame = view.bounds
      //  blurView.alpha = 0.4
      //  view.addSubview(blurView)
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(line)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(subTitleLabel)
        backgroundView.addSubview(yesButton)
        backgroundView.addSubview(noButton)
        
        backgroundView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(303)
        }
        line.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(5)
            make.width.equalTo(64)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.left.equalToSuperview().inset(24)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))! {
            return false
        }
        return true
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        let rootVC = UINavigationController(rootViewController: OnboardingViewController())
        
        view.window?.rootViewController = rootVC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissView()
    }
}

