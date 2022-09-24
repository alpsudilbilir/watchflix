//
//  MovieService.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 15.09.2022.
//

import Foundation


final class MovieService {
    
    static let shared = MovieService()
    
    private init() { }
    
    
    private func createRequest(with url: URL?, type: APISettings.HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        completion(request)
    }
    
    
    //MARK: Get Movies
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + APIConstants.POPULAR_MOVIES + APIConstants.API_KEY), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let movies = response.results
                    completion(.success(movies))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    }
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + APIConstants.TRENDING_MOVIES + APIConstants.API_KEY), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let movies = response.results
                    completion(.success(movies))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + APIConstants.TOP_RATED_MOVIES + APIConstants.API_KEY), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print((APISettings.APIError.failedToGetData))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let movies = response.results
                    completion(.success(movies))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
}
