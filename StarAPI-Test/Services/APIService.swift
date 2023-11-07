//
//  APIService.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

typealias ResultHandler1 = (Result<[Launch], APIError>) -> Void

struct APIService: ServiceProtocol {
    
    func fetchLaunches(url: URL?, completion: @escaping ResultHandler1) {
        
        guard let url = url else {
            let error = APIError.badUrl
            completion(Result.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let launches = try decoder.decode([Launch].self, from: data)
                    completion(Result.success(launches))
                    print(launches)
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
