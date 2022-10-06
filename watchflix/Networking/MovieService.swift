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
    
    
    //MARK: - Get Movies
    
    func getById(with id: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.MOVIE + "/\(id)?" + APIConstants.API_KEY), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.POPULAR_MOVIES + APIConstants.API_KEY + "&page=\(APIConstants.PAGE)"), type: .GET) { request in
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
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.TRENDING_MOVIES + APIConstants.API_KEY + "&page=\(APIConstants.PAGE)"), type: .GET) { request in
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
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.TOP_RATED_MOVIES + APIConstants.API_KEY + "&page=\(APIConstants.PAGE)"), type: .GET) { request in
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
    
    func getUpcomings(completion: @escaping (Result<[Movie], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.UPCOMING + APIConstants.API_KEY ), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let upcomings = response.results
                    completion(.success(upcomings))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    func getNowPlayings(completion: @escaping (Result<[Movie], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.NOW_PLAYING + APIConstants.API_KEY +
                                "&page=\(APIConstants.PAGE + 4)" ), type: .GET) { request in
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
    
    func getCast(with id: Int, completion: @escaping (Result<[Cast], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.MOVIE + "/\(id)" + Endpoints.CAST + APIConstants.API_KEY), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                do {
                    let response = try JSONDecoder().decode(CastResponse.self, from: data)
                    let cast = response.cast
                    completion(.success(cast))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    }
    
    //MARK: - Get TV Series
    
    func getPopularSeries(completion: @escaping (Result<[TV], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.POPULAR_TV + APIConstants.API_KEY + "&page=\(APIConstants.PAGE)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(TVResponse.self, from: data)
                    let series = response.results
                    completion(.success(series))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getTopRatedSeries(completion: @escaping (Result<[TV], Error>) -> Void) {
        createRequest(with: URL(string: APIConstants.BASE_URL + Endpoints.TOP_RATED_TV + APIConstants.API_KEY + "&page=\(APIConstants.PAGE)" ), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(APISettings.APIError.failedToGetData)
                    return
                }
                do {
                    let response = try JSONDecoder().decode(TVResponse.self, from: data)
                    let series = response.results
                    completion(.success(series))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}
