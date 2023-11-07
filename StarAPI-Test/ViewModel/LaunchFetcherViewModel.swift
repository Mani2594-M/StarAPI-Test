//
//  LaunchFetcherViewModel.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import Foundation

class LaunchFetcherViewModel: ObservableObject {
    
    @Published var launches = [Launch]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = APIService()) {
        self.service = service
        fetchAllLaunches()
    }
    
    func fetchAllLaunches() {
        
        isLoading = true
        errorMessage = nil
        
        let service = APIService()
        let url = URL(string: Constant.API.launchUrl)
        service.fetchLaunches(url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let launches):
                    self.launches = launches
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
    
    static func errorState() -> LaunchFetcherViewModel {
        let fetcher = LaunchFetcherViewModel()
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return fetcher
    }
    
    static func successState() -> LaunchFetcherViewModel {
        let fetcher = LaunchFetcherViewModel()
        fetcher.launches = [Launch.testLaunch1(), Launch.testLaunch2()]
        return fetcher
    }
}
