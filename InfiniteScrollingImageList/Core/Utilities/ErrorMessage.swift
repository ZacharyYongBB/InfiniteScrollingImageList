//
//  ErrorMessage.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 15/7/24.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidURL = "Invalid URL"
    case networkError = "Network error"
    case httpError = "HTTP error"
    case decodingError = "Decoding error"
    case dataError = "Data error"
    case unknownError = "Unknown error"

    var developerMessage: String {
        switch self {
        case .invalidURL:
            return "The URL used to fetch images is invalid."
        case .networkError:
            return "A network error occurred. Please check your connection."
        case .httpError:
            return "Received an error response from the server."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .dataError:
            return "The data received could not be processed."
        case .unknownError:
            return "An unknown error occurred."
        }
    }

    var userFriendlyMessage: String {
        switch self {
        case .invalidURL:
            return "There was an issue with the URL. Please try again later."
        case .networkError:
            return "Network error. Please check your internet connection."
        case .httpError:
            return "There was a problem with the server response. Please try again later."
        case .decodingError:
            return "There was a problem processing the data. Please try again."
        case .dataError:
            return "The data received was not in the expected format. Please try again."
        case .unknownError:
            return "An unexpected error occurred. Please try again later."
        }
    }
}
