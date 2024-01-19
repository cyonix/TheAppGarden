//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation

public struct FlickrFeedMedia: Decodable {
    public let url: URL
    
    enum CodingKeys: String, CodingKey {
        case url = "m"
    }
}
