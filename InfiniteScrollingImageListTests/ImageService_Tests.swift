//
//  ImageServiceTests.swift
//  InfiniteScrollingImageListTests
//
//  Created by Zachary on 16/7/24.
//

import XCTest
@testable import InfiniteScrollingImageList

final class ImageService_Tests: XCTestCase {

    var imageService: ImageService!

    override func setUpWithError() throws {
        super.setUp()
        imageService = ImageService()
    }

    override func tearDownWithError() throws {
        imageService = nil
        super.tearDown()
    }

    func test_ImageService_fetchImages_success() async {
        do {
            let images = try await imageService.fetchImages(page: 1, limit: 10)
            XCTAssertFalse(images.isEmpty, "Images should be fetched successfully.")
        } catch {
            XCTFail("fetchImages() threw an error: \(error)")
        }
    }

    func test_ImageService_fetchImages_invalidURL() async {
        let mockService = MockInvalidURLImageService()
        do {
            _ = try await mockService.fetchImages(page: 1, limit: 10)
            XCTFail("fetchImages() should throw an error for invalid URL.")
        } catch let error as ErrorMessage {
            XCTAssertEqual(error, .invalidURL, "Error should be .invalidURL.")
        } catch {
            XCTFail("fetchImages() threw an unexpected error: \(error)")
        }
    }

    func test_ImageService_fetchImages_networkError() async {
        let mockService = MockNetworkErrorImageService()
        do {
            _ = try await mockService.fetchImages(page: 1, limit: 10)
            XCTFail("fetchImages() should throw a network error.")
        } catch let error as ErrorMessage {
            XCTAssertEqual(error, .networkError, "Error should be .networkError.")
        } catch {
            XCTFail("fetchImages() threw an unexpected error: \(error)")
        }
    }


}
