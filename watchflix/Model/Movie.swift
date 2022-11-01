//
//  Movie.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String?
    let release_date: String?
}


