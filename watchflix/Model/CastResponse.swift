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

}
//{
//    "id": 616037,
//    "cast": [
//        {
//            "adult": false,
//            "gender": 2,
//            "id": 74568,
//            "known_for_department": "Acting",
//            "name": "Chris Hemsworth",
//            "original_name": "Chris Hemsworth",
//            "popularity": 118.029,
//            "profile_path": "/jpurJ9jAcLCYjgHHfYF32m3zJYm.jpg",
//            "cast_id": 85,
//            "character": "Thor Odinson",
//            "credit_id": "62c8c25290b87e00f53973fb",
//            "order": 0
//        },
