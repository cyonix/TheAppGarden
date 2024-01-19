//
//  Created by Austin Ugbeme on 1/18/24.
//

import AppFoundation
import Dependencies
import FlickrSDK
import Foundation
import OSLog

enum Destination: Hashable {
    case feedDetail(FeedItem)
}

final class RootViewModel: ObservableObject {
    @MainActor
    @Published private(set) var state: ViewState = .idle
    @Published var searchText = ""
    @Published var destination: [Destination] = []
    @Dependency(\.flickrSDK) var flickrSDK
    
    private var searchTask: Task<Void, Never>?

    init() {
        
    }

    func onSearchTapped() {
        searchTask?.cancel()
        searchTask = Task {
            do {
                let searchValues = searchText.components(separatedBy: ",")

                Logger.default.info("Will fetch photos for tags: \(searchValues)")
                
                let photosFeed = try await flickrSDK.feeds.fetchPublicPhotos(tags: searchValues)
                let items = photosFeed.items.map(FeedItem.init)
                Logger.default.info("Found items with count: \(items.count)")
                
                await updateState(to: .loaded(items: items))
            } catch {
                Logger.default.error("Failed to fetch public photos. Error: \(error)")
                await updateState(to: .error(error.localizedDescription))
            }
        }
    }
    
    func onItemTapped(_ item: FeedItem) {
        destination.append(.feedDetail(item))
    }

    @MainActor
    func onSearchCancelled() {
        switch state {
        case .idle, .loading, .loaded:
            break
        case .error:
            state = .idle
        }
    }

    private func updateState(to viewState: ViewState) async {
        await MainActor.run {
            state = viewState
        }
    }
}

extension RootViewModel {
    enum Constants {
    }
}

extension RootViewModel {
    enum ViewState {
        case idle
        case loading
        case loaded(items: [FeedItem])
        case error(String)
    }
}

extension FeedItem {
    init(_ flickrFeedItem: FlickrFeedItem) {
        self.init(
            title: flickrFeedItem.title, 
            description: flickrFeedItem.description,
            date: flickrFeedItem.dateTaken, 
            tags: flickrFeedItem.tags.components(separatedBy: " "),
            imageURL: flickrFeedItem.media.url
        )
    }
}
