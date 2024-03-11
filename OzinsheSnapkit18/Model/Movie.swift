//
//  Movie.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import Foundation
import SwiftyJSON

class Movie {
    var id = 0
    var movieType = ""
    var name = ""
    var keyWords = ""
    var description = ""
    var year = 0
    var trend = false
    var timing = 0
    var director = ""
    var producer = ""
    var poster_link = ""
    var video_link = ""
    var watchCount = 0
    var seasonCount = 0
    var seriesCount = 0
    var createdDate = ""
    var lastModifiedDate = ""
    var screenshots:[Screenshot] = []
    var categoryAges: [CategoryAge] = []
    var genres: [Genre] = []
    var categories: [Category] = []
    var favorite = false
    
    init() {
    }
    
    init(json: JSON) {
        
        if let temp = json["id"].int {
            id = temp
        }
        if let temp = json["movieType"].string {
            movieType = temp
        }
        if let temp = json["name"].string {
            name = temp
        }
        if let temp = json["keyWords"].string {
            keyWords = temp
        }
        if let temp = json["description"].string {
            description = temp
        }
        if let temp = json["year"].int {
            year = temp
        }
        if let temp = json["trend"].bool {
            trend = temp
        }
        if let temp = json["timing"].int {
            timing = temp
        }
        if let temp = json["director"].string {
            director = temp
        }
        if let temp = json["producer"].string {
            producer = temp
        }
        if  json["poster"].exists() {
            if let temp = json ["poster"]["link"].string{
                poster_link = temp
            }
        }
        if  json["video"].exists() {
            if let temp = json["video"]["link"].string {
                video_link = temp
            }
        }
        if let temp = json["watchCount"].int {
            watchCount = temp
        }
        if let temp = json["seasonCount"].int {
            seasonCount = temp
        }
        if let temp = json["seriesCount"].int {
            seriesCount = temp
        }
        if let temp = json["createdDate"].string {
            createdDate = temp
        }
        if let temp = json["lastModifiedDate"].string {
            lastModifiedDate = temp
        }
        if let temp = json["favorite"].bool {
            favorite = temp
        }
        
        if let items = json["categories"].array {
            for item in items {
                let category = Category(json: item)
                
                categories.append(category)
            }
            if let items = json["genres"].array {
                for item in items {
                    let genre = Genre(json: item)
                    
                    genres.append(genre)
                }
                if let items = json["categoryAges"].array {
                    for item in items {
                        let ages = CategoryAge(json: item)
                        
                        categoryAges.append(ages)
                    }
                    if let items = json["screenshots"].array {
                        for item in items {
                            let screenshot = Screenshot(json: item)
                            
                            screenshots.append(screenshot)
                        }
                    }
                }
            }
        }
    }
    
}
