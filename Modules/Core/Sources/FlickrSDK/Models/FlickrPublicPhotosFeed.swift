//
//  Created by Austin Ugbeme on 1/17/24.
//

import Core
import Foundation

public struct FlickrPublicPhotosFeed: Decodable {
    public let title: String
    public let link: URL
    public let description: String
    @CodableDate<RFC3339DateFormatterProvider> public var modified: Date
    public let items: [FlickrFeedItem]
}
