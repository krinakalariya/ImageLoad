//
//  ImageModel.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//
import UIKit
import Foundation

struct PhotoResponse: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let id: Int
    let url: String
    let src: PhotoSource
}

struct PhotoSource: Codable {
    let medium: String
}
