//
//  HomeViewModel.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 15/7/24.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoadingMore = false
    @Published var alertMessage: String? = nil
    @Published var showAlert = false
    @Published var imagesPerPage: Int = 10 // Default value
    private var currentPage = 1
    private let imageService = ImageService()
    
    func fetchImages() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        do {
            let newImages = try await imageService.fetchImages(page: currentPage, limit: imagesPerPage)
            
            for imageModel in newImages {
                if let url = imageModel.download_url, let urlObject = URL(string: url) {
                    if let cachedImage = ImageCache.shared.image(forKey: url) {
                        print("Using cached image for URL: \(url)")
                    } else {
                        let image = await fetchImage(from: urlObject)
                        if let image = image {
                            ImageCache.shared.setImage(image, forKey: url)
                        }
                    }
                }
            }
            
            images.append(contentsOf: newImages)
            currentPage += 1
            
            alertMessage = nil
            showAlert = false
        } catch let error as ErrorMessage {
            alertMessage = error.userFriendlyMessage
            showAlert = true
            print("Developer Error Message: \(error.developerMessage)")
        } catch {
            let unknownError = ErrorMessage.unknownError
            alertMessage = unknownError.userFriendlyMessage
            showAlert = true
            print("Developer Error Message: \(unknownError.developerMessage)")
        }
        isLoadingMore = false
    }
    
    func resetImages() async {
        images.removeAll()
        currentPage = 1
    }
    
    private func fetchImage(from url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Failed to fetch image: \(error)")
            return nil
        }
    }
}
