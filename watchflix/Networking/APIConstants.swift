//
//  APIConstants.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 24.09.2022.
//

import Foundation


struct APIConstants {
    static let baseURL        = "https://api.themoviedb.org/3"
    static let apiKey         = "api_key=8df24f9e84528672bc08a89dca915351"
    static let baseImageURL   = "https://image.tmdb.org/t/p/w500"
    static var page           = 1
    static var pageString     = "&page=\(page)"
}
enum Endpoint: String {
    case movie                = "/movie"
    case popular              = "/movie/popular?"
    case trending             = "/trending/movie/week?"
    case topRated             = "/movie/top_rated?"
    case upcoming             = "/movie/upcoming?"
    case nowPlaying           = "/movie/now_playing?"
    case popularTV            = "/tv/popular?"
    case topRatedTV           = "/tv/top_rated?"
    case latestTV             = "/tv/latest?"
    case cast                 = "/credits?"
    case similarMovies        = "/similar?"
    case search               = "/search/multi?"
    case person               = "/person"
}

