//
//  MoviePlayerViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 24.02.2024.
//

import UIKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {

    //MARK: - Variables
    var movie = Movie()
    var video_link = ""
    
    let player = {
        let view = YouTubePlayerView()
        
        return view
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        player.loadVideoID(video_link)
    }
}
