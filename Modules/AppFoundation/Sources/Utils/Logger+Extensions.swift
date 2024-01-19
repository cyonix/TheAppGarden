//
//  Created by Austin Ugbeme on 1/18/24.
//

import OSLog

extension Logger {
    public static let `default` = Logger(subsystem: subsystem, category: "default")
    
    static let subsystem = "com.austin.TheAppGarden"
}
