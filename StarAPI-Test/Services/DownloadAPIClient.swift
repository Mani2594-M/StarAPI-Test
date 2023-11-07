//
//  DownloadAPIClient.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

protocol SessionProtocol {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class DownloadAPIClient {
    var session: SessionProtocol = URLSession.shared
    
    func downloadData(withUrl url: String) {
        guard let url = URL(string: url) else { fatalError() }
        session.dataTask(with: url) { (data, response, error) in
            // Download data
        }.resume()
    }
}

extension URLSession: SessionProtocol { }
