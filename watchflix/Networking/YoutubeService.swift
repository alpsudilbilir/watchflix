//
//  YoutubeService.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 27.09.2022.
//

import Foundation


final class YoutubeService {
    static let shared = YoutubeService()
    private init() { }
    struct Constants {
        static let baseURL        = "https://www.googleapis.com/youtube/v3"
        static let ytApiKey       = "key=AIzaSyCSz4xq9hqDGgnaKDdUDtR970_jh6P08j8"
        static let ytSearch       = "/search?"
    }
    func getTrailer(with query: String, completion: @escaping (Result<Video, Error>) -> Void) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let query = trimmedQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: Constants.baseURL + Constants.ytSearch + "q=\(query)&" + Constants.ytApiKey) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Failed to get youtube trailer")
                return
            }
            do {
                let response = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                guard let video = response.items.first else { return }
                completion(.success(video.id))
            }
            catch {
                print("Failed to decode data.")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
