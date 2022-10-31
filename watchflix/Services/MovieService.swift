//
//  MovieService.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 15.09.2022.
//

import Foundation

final class MovieService {
    
    static let shared = MovieService()
    
    private init(){}
    
    func request<T: Codable>(for endpoint: Endpoint, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + endpoint.rawValue + APIConstants.apiKey + "&page=\(APIConstants.page)") else { return }
        let task      = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch { completion(.failure(error)) }
        }
        task.resume()
    }
    
    func request<T: Codable>(with id: Int, for endpoint: Endpoint?, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + Endpoint.movie.rawValue + "/\(id)" + (endpoint?.rawValue ?? "?") + APIConstants.apiKey) else { return }
        let task      = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch { completion(.failure(error)) }
        }
        task.resume()
    }
    
    func requestPerson<T: Codable>(with id: Int, for endpoint: Endpoint?, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + Endpoint.person.rawValue + "/\(id)" + (endpoint?.rawValue ?? "?") + APIConstants.apiKey) else { return }
        let task      = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch { completion(.failure(error)) }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Media], Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + Endpoint.search.rawValue + APIConstants.apiKey + "&query=\(query)") else { return }
        let task      = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else { return }
            
            do {
                let response   = try JSONDecoder().decode(SearchResponse.self, from: data)
                let mediaItems = response.results
                completion(.success(mediaItems))
            } catch { completion(.failure(error)) }
        }
        task.resume()
    }
}
