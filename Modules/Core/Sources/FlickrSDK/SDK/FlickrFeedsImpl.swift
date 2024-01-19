//
//  Created by Austin Ugbeme on 1/17/24.
//

import Dependencies
import Foundation
import HTTPTypes

struct FlickrFeedsImpl: FlickrFeeds {
    typealias FeedsQueryParam = FlickrQueryParam.Feeds
    
    private let defaultQueryParams: [URLQueryItem] = [
        .init(name: FeedsQueryParam.format, value: "json"),
        .init(name: FeedsQueryParam.nojsoncallback, value: "1")
    ]
    
    func fetchPublicPhotos(
        with id: String?,
        tags: [String],
        tagMode: FlickrFeedsTagMode
    ) async throws -> FlickrPublicPhotosFeed {
        @Dependency(\.networkSession) var networkSession
        @Dependency(\.environment) var environment
        
        let queryParams: [URLQueryItem] = [
            .init(name: FeedsQueryParam.tags, value: tags.joined(separator: ","))
        ]
        
        let url = environment.baseURL
            .appending(path: "feeds/photos_public.gne")
            .appending(queryItems: defaultQueryParams + queryParams)
        
        let request = HTTPRequest(url: url)
        return try await networkSession.send(request)
    }
    
    
}
