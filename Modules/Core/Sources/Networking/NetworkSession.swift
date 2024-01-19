//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation
import HTTPTypes
import HTTPTypesFoundation

public struct NetworkSession {
    private let fetcher: DataFetcher
    
    public init(fetcher: DataFetcher = URLSession.shared) {
        self.fetcher = fetcher
    }
    
    public func send<Response: Decodable>(
        _ request: HTTPRequest,
        with configuration: HTTPRequestConfiguration = HTTPRequestConfiguration()
    ) async throws -> Response {
        guard let urlRequest = URLRequest(httpRequest: request) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await fetcher.fetch(urlRequest)
        
        try validate(
            response,
            validators: configuration.httpResponseValidators
        )
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    private func validate(
        _ response: URLResponse,
        validators: [HTTPResponseValidator]
    ) throws {
        guard let httpURLResponse = response as? HTTPURLResponse,
            let httpResponse = httpURLResponse.httpResponse else {
            throw NetworkError.invalidResponse(response)
        }
        
        for validator in validators {
            try validator(httpResponse)
        }
    }
}
