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
 ok
 
 
 Evaluation Criteria:
 Functionality
 Code quality (Swift best practices)
 Test coverage
 Performance (memory, CPU)
 */

import SwiftUI

// Main view
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HeaderView(viewModel: viewModel)
            
            ImageListView(viewModel: viewModel)
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

// Header view containing the Stepper
struct HeaderView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Stepper("Images per Page: \(viewModel.imagesPerPage)", value: $viewModel.imagesPerPage, in: 1...100)
            .padding()
            .onChange(of: viewModel.imagesPerPage) {
                viewModel.resetImages()
                Task {
                    await viewModel.fetchImages()
                }
            }
    }
}

// List view for displaying images and load more button
struct ImageListView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
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
}

#Preview {
    HomeView()
}
