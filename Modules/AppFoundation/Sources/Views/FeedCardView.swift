//
//  Created by Austin Ugbeme on 1/18/24.
//

import DesignSystem
import NukeUI
import SwiftUI

public struct FeedCardView: View {
    public let feedItem: FeedItem

    public init(feedItem: FeedItem) {
        self.feedItem = feedItem
    }

    public var body: some View {
        VStack {
            LazyImage(url: feedItem.imageURL) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else {
                    Color.AppGarden.placeholder
                }
            }
            .overlay(alignment: .bottom) {
                excerptView
            }
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: Sizes.small, height: Sizes.small)))
        }
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private var excerptView: some View {
        VStack {
            HStack {
                Text(feedItem.title)
                    .font(.AppGarden.callout)
                Spacer()
            }
            
            HStack {
                Text(feedItem.date, style: .date)
                    .font(.AppGarden.footnote)
                    .foregroundStyle(Color.AppGarden.secondary)
                Spacer()
            }
        }
        .padding()
        .background {
            Color.AppGarden.bright
        }
    }
}

public struct FeedItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let date: Date
    public let tags: [String]
    public let imageURL: URL

    public init(
        title: String,
        description: String,
        date: Date,
        tags: [String],
        imageURL: URL
    ) {
        self.title = title
        self.description = description
        self.date = date
        self.tags = tags
        self.imageURL = imageURL
    }
}

extension FeedItem: Hashable {}

#Preview {
    FeedCardView(feedItem: .init(
        title: "Porcupine Encounter", 
        description: PreviewSupport.description,
        date: Date(),
        tags: [],
        imageURL: PreviewSupport.mockURL
    ))
}
