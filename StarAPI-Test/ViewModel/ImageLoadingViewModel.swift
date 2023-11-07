//
//  ImageLoadingViewModel.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation
import UIKit

class ImageLoadingViewModel: ObservableObject {
    
    let url: String?
    
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init(url: String?) {
        self.url = url
    }
    
    func fetchLaunches() {
        
        guard image == nil && !isLoading else {
            return
        }
        
        guard let url = url, let launchUrl = URL(string: url) else {
            errorMessage = APIError.badUrl.localizedDescription
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let request = URLRequest(url: launchUrl, cachePolicy: .returnCacheDataElseLoad)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                    self?.errorMessage = APIError.badResponse(statusCode: response.statusCode).localizedDescription
                } else if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.errorMessage = APIError.unknown.localizedDescription
                }
            }
        }
        task.resume()
    }
}
