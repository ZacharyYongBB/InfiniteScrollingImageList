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
 used SwiftUI List
 
 Networking: Fetch image data from the API, handling pagination and errors.
 ok
 
 Pagination: Load images in batches as the user scrolls.
 ok
 
 Lazy Loading: Load images only when visible on screen.
 ok
 
 Image Caching: Cache images to avoid re-downloading.
 ok
 
 Testing:
 Unit Tests: Verify networking, pagination, and caching logic.
 UI Tests: Automate user interactions (scrolling, image loading).
 Performance Tests: Monitor memory usage and CPU performance during scrolling.
 
 Bonus Points:
 Error handling with informative messages.
 ok used Alert
 
 Placeholders for images while loading.
 ok
 
 Customization of images per page.
 
 
 Evaluation Criteria:
 Functionality
 Code quality (Swift best practices)
 Test coverage
 Performance (memory, CPU)
 */

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.images) { image in
                    ImageRowView(image: image)
                }
                
                if !viewModel.isLoadingMore {
                    Button(action: {
                        Task {
                            await viewModel.fetchImages()
                        }
                    }) {
                        Text("Load More")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                } else {
                    ProgressView()
                        .padding()
                }
            }
        }
        .task {
            await viewModel.fetchImages()
        }
        .alert(
            isPresented: $viewModel.showAlert
        ) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.alertMessage ?? "An unknown error occurred."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    HomeView()
}
