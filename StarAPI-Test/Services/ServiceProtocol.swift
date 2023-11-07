//
//  ServiceProtocol.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

protocol ServiceProtocol {
    func fetchLaunches(url: URL?, completion: @escaping(Result<[Launch], APIError>) -> Void)
}
