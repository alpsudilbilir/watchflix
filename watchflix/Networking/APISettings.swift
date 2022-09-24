//
//  API.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 15.09.2022.
//

import Foundation


final class APISettings {
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    enum APIError: Error {
        case failedToGetData
    }
}
