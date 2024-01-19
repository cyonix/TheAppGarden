//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation

public struct HTTPRequestConfiguration {
    public var httpResponseValidators: [HTTPResponseValidator]
    
    public init(httpResponseValidators: [HTTPResponseValidator] = [defaultHTTPResponseValidator]) {
        self.httpResponseValidators = httpResponseValidators
    }
}
