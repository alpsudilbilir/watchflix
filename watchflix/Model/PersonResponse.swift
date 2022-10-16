//
//  PersonResponse.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 15.10.2022.
//

import Foundation


struct Person: Codable {
    let id: Int
    let name: String
    let biography: String
    let profile_path: String
}
