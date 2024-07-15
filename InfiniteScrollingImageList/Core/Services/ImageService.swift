//
//  ImageService.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 15/7/24.
//

import Foundation

class ImageService {
    private let baseURL = "https://picsum.photos/v2/list"
    
    func fetchImages(page: Int, limit: Int = 10) async throws -> [ImageModel] {
        let urlString = "\(baseURL)?page=\(page)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            throw ErrorMessage.invalidData
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let images = try JSONDecoder().decode([ImageModel].self, from: data)
        return images
    }
    
}
