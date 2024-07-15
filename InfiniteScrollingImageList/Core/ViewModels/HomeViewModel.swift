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
    private var currentPage = 1
    private let imageService = ImageService()
    
    func fetchImages() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        do {
            let newImages = try await imageService.fetchImages(page: currentPage)
            images.append(contentsOf: newImages)
            currentPage += 1
            alertMessage = nil
            showAlert = false
        } catch let error as ErrorMessage {
            alertMessage = error.userFriendlyMessage
            showAlert = true
        } catch {
            alertMessage = ErrorMessage.unknownError.userFriendlyMessage
            showAlert = true
        }
        isLoadingMore = false
    }
}
