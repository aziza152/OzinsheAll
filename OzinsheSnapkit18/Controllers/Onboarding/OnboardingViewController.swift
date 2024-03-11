//
//  OnboardingViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 09.02.2024.
//

import UIKit
import SnapKit
import AdvancedPageControl

class OnboardingViewController: UIViewController {
    
    let slideArray = ["Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары", "Кез келген құрылғыдан қара. \n Сүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.bounces = false
        collectionView.register(OnboardingViewCell.self, forCellWithReuseIdentifier: "OnboardingViewCell")
        
        return collectionView
    }()
    
   lazy var pageControl : AdvancedPageControlView = {
        let pageControl = AdvancedPageControlView()
        
        pageControl.drawer = ExtendedDotDrawer(
            numberOfPages: slideArray.count,
            height: 6,
            width: 6,
            space: 4,
            raduis: 3,
            indicatorColor: UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1),
            dotsColor: UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1),
            borderWidth: 0
        )
        
        return pageControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func nextButtonTouched() {
        let signInViewController = SignInViewController()
        navigationController?.show(signInViewController, sender: self)
    }
   
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(118)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingViewCell", for: indexPath) as! OnboardingViewCell
        
        cell.foto.image = UIImage(named: "s\(indexPath.row + 1)")
        cell.welcomeLabel.text = "ÖZINŞE-ге қош келдің!"
        cell.infoLabel.text = slideArray[indexPath.row]
        let text = slideArray[indexPath.item]
        cell.setData(text: text)
        
        cell.skipButton.layer.cornerRadius = 8
        if indexPath.row == 2 {
            cell.skipButton.isHidden = true
        }
    cell.skipButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        cell.nextButton.layer.cornerRadius = 12
        if indexPath.row != 2 {
            cell.nextButton.isHidden = true
        }
        
     cell.nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let width = scrollView.frame.width
           let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
           pageControl.setPage(currentPage)
       }
}


       
