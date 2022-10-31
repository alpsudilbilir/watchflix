//
//  Media.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation

struct Media: Codable {
    let id: Int
    let title: String?
    let name: String?
    let poster_path: String?
    let media_type: String
}
