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
    
    func getTrailer(with query: String, completion: @escaping (Result<Video, Error>) -> Void) {
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let query = trimmedQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: YoutubeAPIConstants.BASE_URL + YoutubeAPIConstants.SEARCH + "q=\(query)&" + YoutubeAPIConstants.YOUTUBE_API_KEY) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(APISettings.APIError.failedToGetData)
                print("fail")
                return
            }
            do {
                let response = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                guard let video = response.items.first else { return }
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
