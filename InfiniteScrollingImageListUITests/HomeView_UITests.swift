//
//  HomeView_UITests.swift
//  InfiniteScrollingImageListUITests
//
//  Created by Zachary on 16/7/24.
//

import XCTest

final class HomeView_UITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_homeView_picker_setsImagePerPage() {
        
        // Given
        XCTAssertTrue(app.staticTexts["Images per Page:"].exists)
        
        // When tap on picker filter
        sleep(6)
        // Wait for the images to load
        let collectionViewsQuery = app.collectionViews
        let firstImage = collectionViewsQuery.cells.element(boundBy: 0).images.element(boundBy: 0)
        let secondImage = collectionViewsQuery.cells.element(boundBy: 1).images.element(boundBy: 0)
        let thirdImage = collectionViewsQuery.cells.element(boundBy: 2).images.element(boundBy: 0)
        
        app.buttons["2"].tap()
        
        // Then
        // Ensure the first and second images exist
        XCTAssertTrue(firstImage.waitForExistence(timeout: 5.0))
        XCTAssertTrue(secondImage.waitForExistence(timeout: 5.0))
        
        // Ensure the third image does not exist
        XCTAssertFalse(thirdImage.waitForExistence(timeout: 5.0))
    }
    
    func test_homeView_loadMoreButton_shouldLoadMore() {
        // Given
        let collectionViewsQuery = app.collectionViews
        let loadMoreButtonIdentifier = "Load More"
        
        sleep(5) // Initial wait for setup
        
        // Scroll to the bottom to reveal the "Load More" button
        let bottomElement = collectionViewsQuery.cells.element(boundBy: collectionViewsQuery.cells.count - 1)
        while !app.buttons[loadMoreButtonIdentifier].exists {
            bottomElement.swipeUp()
            sleep(1)
        }
        
        // Ensure the 'Load More' button is visible
        let loadMoreButton = app.buttons[loadMoreButtonIdentifier]
        XCTAssertTrue(loadMoreButton.exists, "The 'Load More' button should exist at the bottom of the list")
        
        // Tap the 'Load More' button
        loadMoreButton.tap()
        
        // Define expectation for 'Load More' button disappearance
        let loadMoreButtonDisappearedExpectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == NO"),
            object: loadMoreButton
        )
        
        // Wait for the condition to be met
        let result = XCTWaiter.wait(for: [loadMoreButtonDisappearedExpectation], timeout: 10)
        
        // Verify the result of the expectation
        if result == .completed {
            print("Loaded More")
        } else {
            XCTFail("Asynchronous wait failed: \(result.rawValue)")
        }
    }
    
    
    
}
