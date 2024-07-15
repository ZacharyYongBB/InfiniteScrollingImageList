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
            AsyncImage(url: URL(string: image.download_url ?? "")) { phase in
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
            Text(image.author ?? "Unknown Author")
                .font(.caption)
        }
    }
}
