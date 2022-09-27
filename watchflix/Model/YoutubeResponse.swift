//
//  YoutubeResponse.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 27.09.2022.
//

import Foundation


struct YoutubeResponse: Codable {
    let items: [Videos]
}

struct Videos: Codable {
    let id: Video
}

struct Video: Codable {
    let kind: String
    let videoId: String
    
}
