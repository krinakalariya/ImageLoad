//
//  Extension.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//

import UIKit

extension UIImageView {
    
    private static let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from urlString: String) {
        // Check cache first
        if let cachedImage = UIImageView.imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }
    }
}
