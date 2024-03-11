//
//  MovieProtocol.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 14.02.2024.
//

import Foundation

protocol MovieProtocol: AnyObject {
    func movieDidSelect(movie: Movie)
    func ageDidSelect(id: Int, name: String)
    func genreDidSelect(id: Int, name: String)
}
