//
//  HomeViewModel_Tests.swift
//  InfiniteScrollingImageListTests
//
//  Created by Zachary on 16/7/24.
//

import XCTest
@testable import InfiniteScrollingImageList

final class HomeViewModel_Tests: XCTestCase {
    
    var viewModel: HomeViewModel?
    
    @MainActor
    override func setUpWithError() throws {
        // Setup code if needed
        viewModel = HomeViewModel()
    }
    
    @MainActor
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    @MainActor
    func test_HomeViewModel_images_shouldStartEmpty() {
        let vm = HomeViewModel()
        XCTAssertTrue(vm.images.isEmpty)
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldAppendImages() async {
        let vm = HomeViewModel()
        Task {
            try await vm.fetchImages()
            XCTAssertGreaterThan(vm.images.count, 0)
        }
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldSetIsLoadingMoreTrueThenFalse() async {
        let vm = HomeViewModel()
        Task {
            try await vm.fetchImages()
            XCTAssertTrue(vm.isLoadingMore)
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            XCTAssertFalse(vm.isLoadingMore)
        }
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldThrowError() async {
        let mockImageService = MockRandomErrorImageService()
        let vm = HomeViewModel(imageService: mockImageService)
        try? await vm.fetchImages()
        
        XCTAssertNotNil(vm.alertMessage)
        XCTAssertTrue(vm.showAlert)
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldHandleError() async {
        let mockImageService = MockRandomErrorImageService()
        let vm = HomeViewModel(imageService: mockImageService)
        try? await vm.fetchImages()
        
        XCTAssertNotNil(vm.alertMessage)
        XCTAssertTrue(vm.showAlert)
    }
    
    @MainActor
    func test_HomeViewModel_resetImages_shouldClearImages() async {
        let vm = HomeViewModel()
        vm.images.append(ImageModel(id: "1", author: nil, width: nil, height: nil, url: nil, download_url: "https://example.com/image1.jpg"))
        vm.images.append(ImageModel(id: "2", author: nil, width: nil, height: nil, url: nil, download_url: "https://example.com/image2.jpg"))
        Task {
            await vm.resetImages()
            XCTAssertTrue(vm.images.isEmpty)
        }
    }
    
    @MainActor
    func test_HomeViewModel_fetchImage_shouldHandleFailure() async {
        let mockImageService = MockRandomErrorImageService()
        let vm = HomeViewModel(imageService: mockImageService)
        try? await vm.fetchImages()
        XCTAssertNotNil(vm.alertMessage)
        XCTAssertTrue(vm.showAlert)
    }
    
    @MainActor
    func test_HomeViewModel_fetchImages_shouldResetLoadingStateOnFailure() async {
        let mockImageService = MockRandomErrorImageService()
        let vm = HomeViewModel(imageService: mockImageService)
        try? await vm.fetchImages()
        XCTAssertFalse(vm.isLoadingMore)
    }
    
    @MainActor
    func testPerformanceOfImageFetching() throws {
        let vm = HomeViewModel()
        self.measure {
            Task {
                try? await vm.fetchImages()
            }
        }
    }
}
