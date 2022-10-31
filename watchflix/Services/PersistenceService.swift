//
//  PersistenceService.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation

struct PersistenceService {
    
    static let defaults = UserDefaults.standard
    
    enum ListType: String {
        case favorite
        case watchlist
    }
    enum PersistenceActionType {
        case add
        case remove
    }
    
    static func updateWith(movie: Movie, listType: ListType, actionType: PersistenceActionType, completion: @escaping (WFError?) -> Void ) {
        getMovies(type: listType) { result in
            switch result {
            case .success(var movies):
                switch actionType {
                case .add:
                    guard !movies.contains(where: { $0.id == movie.id }) else {
                        completion(.alreadyInList)
                        return
                    }
                    movies.append(movie)
                case .remove:
                    movies.removeAll { $0.id == movie.id }
                }
                completion(setMovies(movies: movies, type: listType))
            case .failure(let error):
                print(error)
                completion(.unableToAdd)
            }
        }
         
    }

    static func setMovies(movies: [Movie], type: ListType) -> WFError? {
        do {
            switch type {
            case .favorite:
                let encodedMovies = try JSONEncoder().encode(movies)
                defaults.setValue(encodedMovies, forKey: type.rawValue)
                return nil
            case .watchlist:
                let encodedMovies = try JSONEncoder().encode(movies)
                defaults.setValue(encodedMovies, forKey: type.rawValue)
                return nil
            }
        } catch { return .unableToAdd }
    }
    
    static func getMovies(type: ListType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let data = defaults.object(forKey: type.rawValue) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            completion(.success(movies))
        } catch { completion(.failure(error)) }
    }
}
