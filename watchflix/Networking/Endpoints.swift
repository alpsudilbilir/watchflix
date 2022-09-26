//
//  Endpoints.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 26.09.2022.
//

import Foundation


struct Endpoints {
    
    //MARK: - Movies
    
    static let POPULAR_MOVIES = "/movie/popular?"
    static let TRENDING_MOVIES = "/trending/movie/week?"
    static let TOP_RATED_MOVIES = "/movie/top_rated?"
    static let UPCOMING = "/movie/upcoming?"
    static let NOW_PLAYING = "/movie/now_playing?"
    
    //MARK: - TV
    
    static let POPULAR_TV = "/tv/popular?"
    static let TOP_RATED_TV = "/tv/top_rated?"
    static let LATEST_TV = "/tv/latest?"
}
