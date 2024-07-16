//
//  MockErrorImageService.swift
//  InfiniteScrollingImageListTests
//
//  Created by Zachary on 16/7/24.
//

import Foundation
@testable import InfiniteScrollingImageList


class MockRandomErrorImageService: ImageService {
    
    private let errors: [ErrorMessage] = [
        .invalidURL,
        .networkError,
        .httpError,
        .decodingError,
        .dataError,
        .unknownError
    ]
    
    override func fetchImages(page: Int, limit: Int) async throws -> [ImageModel] {
        let randomIndex = Int.random(in: 0..<errors.count)
        let randomError = errors[randomIndex]
        throw randomError
    }
}
