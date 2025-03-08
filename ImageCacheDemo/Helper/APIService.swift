//
//  APIService.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//

import Foundation
import UIKit

class APIService {
    private let baseURL = "https://api.pexels.com/v1/search"
    private let apiKey = "Q1L4b0M3NzAHFAx7ElRvTYvRQH78o5NFVlbCh6MiZacMvdWszj2Hc8Dj"
    let query = "nature"
    
    func fetchPhotosAsync(page: Int) async throws -> [Photo] {
        let urlString = "\(baseURL)?query=\(query)&per_page=20&page=\(page)"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PhotoResponse.self, from: data)
        return response.photos
    }
    
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(PhotoResponse.self, from: data)
                completion(.success(response.photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
