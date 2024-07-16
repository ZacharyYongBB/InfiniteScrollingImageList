//
//  ErrorMessage_Tests.swift
//  InfiniteScrollingImageListTests
//
//  Created by Zachary on 16/7/24.
//

import XCTest
@testable import InfiniteScrollingImageList

final class ErrorMessage_Tests: XCTestCase {
    
    func test_ErrorMessage_developerMessages() {
        XCTAssertEqual(ErrorMessage.invalidURL.developerMessage, "The URL used to fetch images is invalid.")
        XCTAssertEqual(ErrorMessage.networkError.developerMessage, "A network error occurred. Please check your connection.")
        XCTAssertEqual(ErrorMessage.httpError.developerMessage, "Received an error response from the server.")
        XCTAssertEqual(ErrorMessage.decodingError.developerMessage, "Failed to decode the response from the server.")
        XCTAssertEqual(ErrorMessage.dataError.developerMessage, "The data received could not be processed.")
        XCTAssertEqual(ErrorMessage.unknownError.developerMessage, "An unknown error occurred.")
    }

    func test_ErrorMessage_userFriendlyMessages() {
        XCTAssertEqual(ErrorMessage.invalidURL.userFriendlyMessage, "There was an issue with the URL. Please try again later.")
        XCTAssertEqual(ErrorMessage.networkError.userFriendlyMessage, "Network error. Please check your internet connection.")
        XCTAssertEqual(ErrorMessage.httpError.userFriendlyMessage, "There was a problem with the server response. Please try again later.")
        XCTAssertEqual(ErrorMessage.decodingError.userFriendlyMessage, "There was a problem processing the data. Please try again.")
        XCTAssertEqual(ErrorMessage.dataError.userFriendlyMessage, "The data received was not in the expected format. Please try again.")
        XCTAssertEqual(ErrorMessage.unknownError.userFriendlyMessage, "An unexpected error occurred. Please try again later.")
    }
}
