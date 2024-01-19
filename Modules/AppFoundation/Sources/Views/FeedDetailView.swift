//
//  Created by Austin Ugbeme on 1/19/24.
//

import Core
import DesignSystem
import NukeUI
import SwiftUI

public struct FeedDetailView: View {
    @Environment(\.dismiss) var dismiss
    public let feedItem: FeedItem

    @State private var imageSize: CGSize = .zero

    public init(feedItem: FeedItem) {
        self.feedItem = feedItem
    }
    
    func doStuff() {}
    public var body: some View {
        ScrollView {
            VStack {
                LazyImage(url: feedItem.imageURL) { state in
                    let _ = updateImageSize(using: state)

                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } else {
                        Color.AppGarden.placeholder
                    }
                }
                    
                detailsView
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: navigationBackButton)
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    @MainActor
    private func updateImageSize(using state: LazyImageState) {
        DispatchQueue.main.async {
            imageSize = state.imageContainer?.image.size ?? .zero
        }
    }

    @ViewBuilder
    private var detailsView: some View {
        VStack(alignment: .leading, spacing: Sizes.medium) {
            HStack {
                if imageSize == .zero {
                    Text(feedItem.title)
                        .font(.AppGarden.callout)
                } else {
                    Text("\(feedItem.title) [\(Int(imageSize.width)) x \(Int(imageSize.height))]")
                        .font(.AppGarden.callout)
                }
                Spacer()
            }
            
            HStack {
                Text(feedItem.date, style: .date)
                    .font(.AppGarden.footnote)
                    .foregroundStyle(Color.AppGarden.secondary)
                Spacer()
            }
            
            HStack {
                ForEach(feedItem.tags.prefix(4), id: \.self) {
                    CapsuleButton(text: $0, onTap: {})
                }
            }
        }
        .background {
            Color.AppGarden.bright
        }
    }
    
    private func navigationBackButton() -> some View {
        Button(
            action: { dismiss() },
            label: {
                Image(systemName: "chevron.left.circle.fill")
                    .aspectRatio(contentMode: .fit)
                    .font(.AppGarden.title)
                    .foregroundStyle(Color.AppGarden.bright)
                    .opacity(0.7)
            }
        )
    }
}

#Preview {
    NavigationStack {
        FeedDetailView(feedItem: .init(
            title: "Porcupine Encounter",
            description: PreviewSupport.description,
            date: Date(), 
            tags: ["willys", "toledo", "oil", "knight"],
            imageURL: PreviewSupport.mockURL
        ))
    }
}

extension String {
    func toAttributedText() -> Text {
        let attributedString = AttributedString(stringLiteral: self)
        return Text(attributedString)
    }
}
