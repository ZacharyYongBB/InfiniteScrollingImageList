//
//  ErrorMessage.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 15/7/24.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidData = "The data received from the server was invalid."
    case badData = "The data could not be processed."
    case networkError = "A network error occurred. Please check your connection and try again."
    case decodingError = "Failed to decode the response from the server."
    case unknownError = "An unknown error occurred. Please try again later."

    var userFriendlyMessage: String {
        switch self {
        case .invalidData:
            return "The data received was invalid. Please try again later."
        case .badData:
            return "There was an issue with the data we received. Please try again."
        case .networkError:
            return "Network error. Please check your internet connection and try again."
        case .decodingError:
            return "There was a problem processing the data. Please try again."
        case .unknownError:
            return "An unexpected error occurred. Please try again later."
        }
    }
}
