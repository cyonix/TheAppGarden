//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation

public enum FlickrSDK {
    public static func configure() -> FlickrSDKClient {
        FlickrSDKClientImpl()
    }
}

public protocol FlickrSDKClient {
    var feeds: FlickrFeeds { get }
}

public protocol FlickrFeeds {
    func fetchPublicPhotos(
        with id: String?,
        tags: [String],
        tagMode: FlickrFeedsTagMode
    ) async throws -> FlickrPublicPhotosFeed
}

public extension FlickrFeeds {
    func fetchPublicPhotos(tags: [String]) async throws -> FlickrPublicPhotosFeed {
        try await fetchPublicPhotos(with: nil, tags: tags, tagMode: .all)
    }
}

public enum FlickrFeedsTagMode: String {
    case all
    case any
}

public enum FlickrFeedsLanguage: String {
    case english = "en-us"
}

