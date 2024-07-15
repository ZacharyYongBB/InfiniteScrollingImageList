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
            throw ErrorMessage.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw ErrorMessage.httpError
            }
            
            do {
                let images = try JSONDecoder().decode([ImageModel].self, from: data)
                return images
            } catch {
                throw ErrorMessage.decodingError
            }
            
        } catch {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .timedOut, .cannotFindHost:
                    throw ErrorMessage.networkError
                default:
                    throw ErrorMessage.unknownError
                }
            } else {
                throw ErrorMessage.unknownError
            }
        }
    }
}

