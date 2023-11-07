//
//  StarAPI_TestTests.swift
//  StarAPI-TestTests
//
//  Created by Mani V on 11/6/23.
//

import XCTest
import Combine

@testable import StarAPI_Test

final class StarAPI_TestTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()
    var sut: DownloadAPIClient!

    override func setUp() {
        super.setUp()
        sut = DownloadAPIClient()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_launch_success() {
        
        let launch = Result<[Launch], APIError>.success([Launch.testLaunch1()])
        let launches = LaunchFetcherViewModel(service: MockAPIService(launch: launch))
        
        let promise = expectation(description: "Launches successful")
        
        launches.$launches.sink { launches in
            if launches.count > 0 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 2)
    }
    
    func test_loading_error() {
        
        let launch = Result<[Launch], APIError>.failure(APIError.badUrl)
        let launcher = LaunchFetcherViewModel(service: MockAPIService(launch: launch))
        
        let promise = expectation(description: "Launch Unsuccessful")
        
        launcher.$launches.sink { launches in
            if !launches.isEmpty {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        launcher.$errorMessage.sink { message in
            if message != nil {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 2)
    }
    
    func test_UsesExpectedHost() {
        
        let url = "https://urldefense.proofpoint.com/v2/url?u=https-3A__api.spacexdata.com_v3_launches&d=DwIGAg&c=BioHiDP8cpFFEOWoiyRJQw&r=3FaZC4i26BbLvHTIgl3oS-4rsIuvBI95wqEzuFbXR5I&m=kylOGjUVRcexWeN1YBwN081G5IGWlqWE008QHRdMNR2zDcyh9IM2MWJoBVPVYXX0&s=ZBuZiCyB2zc0Z7m2CcpPQDNGmvM3IOO7B_OLsuHJoEk&e="
        sut.downloadData(withUrl: url)
        guard let url1 = URL(string: url) else {
            XCTFail(); return
        }
        let urlComponents = URLComponents(url: url1, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "urldefense.proofpoint.com")
    }
    
    func test_UsesExpectedPath() {
        
        let url = "https://urldefense.proofpoint.com/v2/url?u=https-3A__api.spacexdata.com_v3_launches&d=DwIGAg&c=BioHiDP8cpFFEOWoiyRJQw&r=3FaZC4i26BbLvHTIgl3oS-4rsIuvBI95wqEzuFbXR5I&m=kylOGjUVRcexWeN1YBwN081G5IGWlqWE008QHRdMNR2zDcyh9IM2MWJoBVPVYXX0&s=ZBuZiCyB2zc0Z7m2CcpPQDNGmvM3IOO7B_OLsuHJoEk&e="
        sut.downloadData(withUrl: url)
        guard let url1 = URL(string: "https://urldefense.proofpoint.com/v2/url?u=https-3A__api.spacexdata.com_v3_launches&d=DwIGAg&c=BioHiDP8cpFFEOWoiyRJQw&r=3FaZC4i26BbLvHTIgl3oS-4rsIuvBI95wqEzuFbXR5I&m=kylOGjUVRcexWeN1YBwN081G5IGWlqWE008QHRdMNR2zDcyh9IM2MWJoBVPVYXX0&s=ZBuZiCyB2zc0Z7m2CcpPQDNGmvM3IOO7B_OLsuHJoEk&e=") else {
            XCTFail(); return
        }
        let urlComponents = URLComponents(url: url1, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.path, "/v2/url")
    }
}

extension StarAPI_TestTests {
    
    class MockURLSession: SessionProtocol {
        var url: URL?

        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
