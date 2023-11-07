//
//  MockAPIService.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

struct MockAPIService: ServiceProtocol {
    
    var launch: Result<[Launch], APIError>
    
    func fetchLaunches(url: URL?, completion: @escaping (Result<[Launch], APIError>) -> Void) {
        completion(launch)
    }
}
