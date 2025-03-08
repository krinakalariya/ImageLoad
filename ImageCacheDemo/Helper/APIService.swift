//
//  APIService.swift
//  ImageCacheDemo
//
//  Created by krina kalariya on 08/03/25.
//

import Foundation
import UIKit

class APIService {
    private let baseURL = "https://api.pexels.com/v1/search"//Used Pexel api to fetch High Quality Images.
    private let apiKey = "Q1L4b0M3NzAHFAx7ElRvTYvRQH78o5NFVlbCh6MiZacMvdWszj2Hc8Dj"//Pexel api key
    let query = "nature"//Added Default query as nature for fetch image
    
    func fetchPhotosAsync(page: Int) async throws -> [Photo] {
        let urlString = "\(baseURL)?query=\(query)&per_page=20&page=\(page)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PhotoResponse.self, from: data)
        return response.photos
    }
}
