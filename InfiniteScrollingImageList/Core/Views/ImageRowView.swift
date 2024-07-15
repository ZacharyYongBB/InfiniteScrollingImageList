//
//  ImageRowView.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 15/7/24.
//

import SwiftUI

struct ImageRowView: View {
    let image: ImageModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: image.download_url ?? "") {
                
                if let cachedImage = ImageCache.shared.image(forKey: url.absoluteString) {
                    Image(uiImage: cachedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        case .failure:
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.gray)
            }
            Text(image.author ?? "Unknown Author")
                .font(.caption)
        }
    }
}
