//
//  ImageCacheTests.swift
//  InfiniteScrollingImageListTests
//
//  Created by Zachary on 16/7/24.
//

import XCTest
@testable import InfiniteScrollingImageList

final class ImageCache_Tests: XCTestCase {
    
    func test_ImageCache_setAndRetrieveImage() {
        let cache = ImageCache.shared
        let image = UIImage(systemName: "star")!
        let key = "testImageKey"

        cache.setImage(image, forKey: key)
        
        if let cachedImage = cache.image(forKey: key) {
            XCTAssertEqual(cachedImage.pngData(), image.pngData(), "Cached image should match the stored image.")
        } else {
            XCTFail("Image should be retrieved from the cache.")
        }
    }

    func test_ImageCache_imageNotFound() {
        let cache = ImageCache.shared
        let key = "nonExistentKey"

        XCTAssertNil(cache.image(forKey: key), "Cache should return nil for non-existent keys.")
    }
}

