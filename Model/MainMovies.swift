//
//  MainMovies.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import Foundation
import SwiftyJSON

enum CellType {
    case mainBanner
    case mainMovie
    case userHistory
    case genre
    case ageCategory
}

class MainMovies {
    var categoryId = 0
    var categoryName = ""
    
    
    var bannerMovie: [BannerMovie] = []
    var movies: [Movie] = []
    var cellType: CellType = .mainMovie
    var categoryAges: [CategoryAge] = []
    var genres: [Genre] = []
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["categoryId"].int {
            self.categoryId = temp
        }
        if let temp = json["categoryName"].string {
            self.categoryName = temp
        }
        if let array = json["movies"].array {
            for item in array {
                let temp = Movie(json: item)
                self.movies.append(temp)
            }
            if let array = json["bannerMovie"].array {
                for item in array {
                    let temp = BannerMovie(json: item)
                    self.bannerMovie.append(temp)
                }
            }
            if let array = json["categoryAges"].array {
                for item in array {
                    let temp = CategoryAge(json: item)
                    self.categoryAges.append(temp)
                }
            }
            if let array = json["genres"].array {
                for item in array {
                    let temp = Genre(json: item)
                    self.genres.append(temp)
                }
            }
        }
    }
}
