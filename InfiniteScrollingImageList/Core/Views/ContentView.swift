//
//  ContentView.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 15/7/24.
//

// Requirement
/*
 Hands-On iOS Test: Infinite Scrolling Image List
 
 Objective:
 Create a Swift iOS app that displays images fetched from the Lorem Picsum API (https://picsum.photos/v2/list) in an infinite scrolling list.
 
 Requirements:
 UI: Display images in a UICollectionView or UITableView.
 Networking: Fetch image data from the API, handling pagination and errors.
 Pagination: Load images in batches as the user scrolls.
 Lazy Loading: Load images only when visible on screen.
 Image Caching: Cache images to avoid re-downloading.
 
 Testing:
 Unit Tests: Verify networking, pagination, and caching logic.
 UI Tests: Automate user interactions (scrolling, image loading).
 Performance Tests: Monitor memory usage and CPU performance during scrolling.
 
 Bonus Points:
 Error handling with informative messages.
 Placeholders for images while loading.
 Customization of images per page.
 Evaluation Criteria:
 Functionality
 Code quality (Swift best practices)
 Test coverage
 Performance (memory, CPU)
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
