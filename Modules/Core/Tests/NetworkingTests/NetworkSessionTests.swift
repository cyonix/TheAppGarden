//
//  Created by Austin Ugbeme on 1/17/24.
//

@testable import Networking
import HTTPTypes
import XCTest

final class NetworkSessionTests: XCTestCase {
    func testSuccessfulResponse() async throws {
        let expectedValue = "Bob"
        let data = try JSONEncoder().encode(MockResponse(value: expectedValue))
        let response = HTTPURLResponse()
        let fetcher = AnonymousDataFetcher { _ in
            (data, response)
        }

        let session = NetworkSession(fetcher: fetcher)
        let request = HTTPRequest(url: .mockAbsoluteURL)
        
        let sessionResponse: MockResponse = try await session.send(request)

        XCTAssertEqual(sessionResponse.value, expectedValue)
    }
    
    func testFailingResponse() async throws {
        let fetcher = AnonymousDataFetcher { _ in
            throw MockError()
        }

        let session = NetworkSession(fetcher: fetcher)
        let request = HTTPRequest(url: .mockAbsoluteURL)
        
        do {
            let _: MockResponse = try await session.send(request)
            XCTFail("Expected response to fail!")
        } catch is MockError {
            // Pass
        } catch {
            XCTFail("Failed with unexpected error type: \(error.self)")
        }
    }
    
    func testResponseValidations() async throws {
        let expectedValue = "Bob"
        let data = try JSONEncoder().encode(MockResponse(value: expectedValue))
        let response = HTTPURLResponse()
        let fetcher = AnonymousDataFetcher { _ in
            (data, response)
        }

        let session = NetworkSession(fetcher: fetcher)
        let request = HTTPRequest(url: .mockAbsoluteURL)
        let requestConfig = HTTPRequestConfiguration(httpResponseValidators: [
            { _ in throw MockError() }
        ])
        
        do {
            let _: MockResponse = try await session.send(
                request,
                with: requestConfig
            )
            XCTFail("Expected response to fail!")
        } catch is MockError {
            // Pass
        } catch {
            XCTFail("Failed with unexpected error type: \(error.self)")
        }
    }
}

struct MockResponse: Codable {
    let value: String
}

struct MockError: Error {}
