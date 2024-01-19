//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidResponse(URLResponse)
    case unacceptableStatusCode(Int)
}
