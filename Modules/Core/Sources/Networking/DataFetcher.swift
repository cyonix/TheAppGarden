//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation

public protocol DataFetcher {
    func fetch(_ request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: DataFetcher {
    public func fetch(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request)
    }
}

struct AnonymousDataFetcher: DataFetcher {
    var fetcher: (URLRequest) async throws -> (Data, URLResponse) = { _ in throw Error() }

    func fetch(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await fetcher(request)
    }
}

extension AnonymousDataFetcher {
    struct Error: Swift.Error {}
}
