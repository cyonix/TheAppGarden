//
//  Created by Austin Ugbeme on 1/18/24.
//

import Combine
import Foundation

extension Task {
    public func toCancellable() -> AnyCancellable {
        AnyCancellable(self.cancel)
    }
    
    public func store(in cancellables: inout Set<AnyCancellable>) {
        toCancellable().store(in: &cancellables)
    }
}
