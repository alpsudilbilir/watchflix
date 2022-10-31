//
//  WFError.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import Foundation

enum WFError: String, Error {
    case unableToAdd   = "There was an error favoriting this user. Please try again."
    case alreadyInList = "This movie is already in your list."
}
