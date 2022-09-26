//
//  APIConstants.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 24.09.2022.
//

import Foundation


struct APIConstants {
    static let BASE_URL  = "https://api.themoviedb.org/3"
    static let API_KEY = "api_key=8df24f9e84528672bc08a89dca915351"
    static let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
    
    
    //MARK: Endpoints
    
    static let POPULAR_MOVIES = "/movie/popular?"
    static let TRENDING_MOVIES = "/trending/movie/week?"
    static let TOP_RATED_MOVIES = "/movie/top_rated?"
    static let UPCOMING = "/movie/upcoming?"
    
}
