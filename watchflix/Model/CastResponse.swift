//
//  CastResponse.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 30.09.2022.
//

import Foundation

struct CastResponse: Codable {
    let cast: [Cast]
}
struct Cast: Codable {
    let character: String
    let name: String
    let order: Int
    let profile_path: String?
    let id: Int
}
