//
//  ImageCache.swift
//  InfiniteScrollingImageList
//
//  Created by Zachary on 16/7/24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func image(forKey key: String) -> UIImage? {
        if let image = cache.object(forKey: key as NSString) {
            print("Image retrieved from cache for key: \(key)")
            return image
        } else {
            print("Image not found in cache for key: \(key)")
            return nil
        }
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        print("Image cached for key: \(key)")
    }
}
