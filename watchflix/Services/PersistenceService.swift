//
//  PersistenceService.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation


public enum ListType: String {
    case favorite
    case watchlist
}

struct PersistenceService {
    
    static let defaults = UserDefaults.standard
    
    static func updateWith(movie: Movie, listType: ListType, button: WFSymbolButton, completion: @escaping (WFError?) -> Void ) {
        getMovies(type: listType) { result in
            switch result {
            case .success(var movies):
                if  movies.contains(where: { $0.id == movie.id }) {
                    movies.removeAll { $0.id == movie.id }
                     }
                else { movies.insert(movie, at: 0) }
                configureButtonSymbols(movie: movie, movies: movies, button: button, type: listType)
                completion(setMovies(movies: movies, type: listType))
            case .failure(let error):
                print(error)
                completion(.unableToAdd)
            }
        }
    }
    
    static func configureButtonSymbols(movie: Movie, movies: [Movie], button: WFSymbolButton, type: ListType) {
        switch type {
        case .watchlist:
            if movies.contains(where: { $0.id == movie.id }) {
                button.configure(with: SFSymbols.bookmarkFill)
            }
            else { button.configure(with: SFSymbols.bookmark) }
        case .favorite:
            if movies.contains(where: { $0.id == movie.id }) {
                button.configure(with: SFSymbols.heartFill)
            }
            else { button.configure(with: SFSymbols.heart) }
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
