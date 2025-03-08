//
//  PhotoCell.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
//    load and cache Image
    func configure(with photo: Photo) {
        imageView.loadImage(from: photo.src.medium)
        imageView.layer.cornerRadius = 8
    }
}
