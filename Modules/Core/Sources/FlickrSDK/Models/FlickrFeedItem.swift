//
//  Created by Austin Ugbeme on 1/17/24.
//

import Core
import Foundation

public struct FlickrFeedItem: Decodable {
    public let title: String
    public let link: URL
    public let media: FlickrFeedMedia
    @CodableDate<ISO8601DateFormatterProvider> public var dateTaken: Date
    public let description: String
    @CodableDate<RFC3339DateFormatterProvider> public var published: Date
    public let author: String
    public let tags: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case tags
    }
}
