//
//  Created by Austin Ugbeme on 1/17/24.
//

import Foundation

struct FlickrSDKClientImpl: FlickrSDKClient {
    var feeds: FlickrFeeds = FlickrFeedsImpl()
}
