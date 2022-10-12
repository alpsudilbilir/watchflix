//
//  SearchResponse.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 12.10.2022.
//

import Foundation

struct SearchResponse: Codable {
    let results: [Media]
}

struct Media: Codable {
    let id: Int
    let title: String?
    let name: String?
    let poster_path: String?
    let media_type: String
}
