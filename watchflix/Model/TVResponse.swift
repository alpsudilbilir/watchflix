//
//  TVResponse.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 26.09.2022.
//

import Foundation

struct TVResponse: Codable {
    let results: [TV]
}
struct TV: Codable {
    let id: Int
    let name: String
    let overview: String
    let vote_average: Double
    let poster_path: String?
}
