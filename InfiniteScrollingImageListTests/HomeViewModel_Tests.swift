//
//  HomeViewModel_Tests.swift
//  InfiniteScrollingImageListTests
//
//  Created by Zachary on 16/7/24.
//

import XCTest
@testable import InfiniteScrollingImageList

// Given

// When

// Then

final class HomeViewModel_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func test_HomeViewModel_images_images_shouldStartEmpty() {
        // Given
        
        
        // When
        let vm = HomeViewModel()
        
        // Then
        XCTAssertTrue(vm.images.isEmpty)
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldAppendImages() async {
        // Given
        let vm = HomeViewModel()
        
        // When
        Task {
            await vm.fetchImages()
            
            // Then
            XCTAssertGreaterThan(vm.images.count, 0)
        }
    }
    
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldSetIsLoadingMoreTrueThenFalse() async {
        // Given
        let vm = HomeViewModel()
        
        // When
        Task {
            await vm.fetchImages()
            
            // Then
            XCTAssertTrue(vm.isLoadingMore)
            
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            
            XCTAssertFalse(vm.isLoadingMore)
        }
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldThrowError() async {
        // Given
        let mockImageService = MockRandomErrorImageService()
        let vm = HomeViewModel(imageService: mockImageService)
        
        // When
        await vm.fetchImages()
        
        // Then
        XCTAssertNotNil(vm.alertMessage)
        XCTAssertTrue(vm.showAlert)
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldHandleError() async {
        // Given
        let vm = HomeViewModel()
        
        // When
        Task {
            await vm.fetchImages()
            
            // Then
            XCTAssertNotNil(vm.alertMessage)
            XCTAssertTrue(vm.showAlert)
        }
    }
    
    @MainActor
    func test_HomeViewModel_resetImages_shouldClearImages() async {
        // Given
        let vm = HomeViewModel()
        Task {
            vm.images.append(ImageModel(id: "1", author: nil, width: nil, height: nil, url: nil, download_url: "https://example.com/image1.jpg"))
            vm.images.append(ImageModel(id: "2", author: nil, width: nil, height: nil, url: nil, download_url: "https://example.com/image2.jpg"))
        }
        
        // When
        Task {
            await vm.resetImages()
            
            // Then
            XCTAssertTrue(vm.images.isEmpty)
        }
    }
    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
