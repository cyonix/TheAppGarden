//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation
import HTTPTypes

public typealias HTTPResponseValidator = @Sendable (HTTPResponse) throws -> Void

public let defaultHTTPResponseValidator: HTTPResponseValidator = { response in
    let responseStatus = response.status
    let responseStatusKind = responseStatus.kind
    guard responseStatusKind == .successful || responseStatusKind == .informational else {
        throw NetworkError.unacceptableStatusCode(responseStatus.code)
    }
}
