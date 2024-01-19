//
//  Created by Austin Ugbeme on 1/19/24.
//

import Foundation

extension Data {
    static let mock = "Mock Data Stream".data(using: .utf8)!
}

extension URL {
    static let mockBaseURL = URL(string: "https://example.com")!
    static let mockRelativeURL = URL(string: "path/to/resource")!
    static let mockAbsoluteURL = URL(string: URL.mockRelativeURL.path, relativeTo: mockBaseURL)!
}
