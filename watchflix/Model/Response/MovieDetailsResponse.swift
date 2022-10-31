//
//  MovieDetailsResponse.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 28.09.2022.
//

import Foundation


struct MovieDetailsResponse: Codable {
    let id: Int
    let genres: [Genre]
    let overview: String
    let poster_path: String
    let release_date: String
    let runtime: Int?
    let title: String
    let tagline: String
    let vote_average: Double
    
}




