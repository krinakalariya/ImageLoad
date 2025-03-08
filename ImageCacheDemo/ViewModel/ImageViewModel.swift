//
//  ImageViewModel.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//
import UIKit
import Foundation

class ImageViewModel {
    
    private var apiService = APIService()
    var photos: [Photo] = []
    private var currentPage = 1
    private var isLoading = false
    var reloadData: (() -> Void)?
    
    func fetchPhotosAsync(loadMore: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        if loadMore { currentPage += 1 }

        Task {
            do {
                let newPhotos = try await apiService.fetchPhotosAsync( page: currentPage)
                DispatchQueue.main.async {
                    self.photos.append(contentsOf: newPhotos)
                    self.isLoading = false
                    self.reloadData?()
                }
            } catch {
                print(" Error fetching photos: \(error)")
                isLoading = false
            }
        }
    }
    
    func fetchPhotos() {
        
        apiService.fetchPhotos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos = photos
                    self?.reloadData?()
                case .failure(let error):
                    print("Error fetching photos: \(error.localizedDescription)")
                }
            }
        }
    }
}

