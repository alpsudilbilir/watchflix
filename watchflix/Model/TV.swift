//
//  TV.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation

struct TV: Codable {
    let id: Int
    let name: String
    let overview: String
    let vote_average: Double
    let poster_path: String?
}
