//
//  Movie.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 24.09.2022.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String?
}
