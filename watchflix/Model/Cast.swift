//
//  Cast.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation

struct Cast: Codable {
    let character: String
    let name: String
    let order: Int
    let profile_path: String?
    let id: Int
}
