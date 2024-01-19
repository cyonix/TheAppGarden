//
//  Created by Austin Ugbeme on 1/17/24.
//

import AppFoundation
import Core
import DesignSystem
import SwiftUI

struct RootView: View {
    @Environment(\.isSearching) private var isSearching: Bool
    @StateObject var viewModel: RootViewModel = RootViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.destination) {
            ScrollView {
                switch viewModel.state {
                case .idle:
                    Text("Hint: Search by entering a phrase or comma delimited words")
                        .font(.AppGarden.footnote)
                        .foregroundStyle(Color.AppGarden.secondary)
                        .padding(.top, Sizes.large)
                        .padding(.horizontal, Sizes.small)
                case .loading:
                    ProgressView()
                case let .loaded(items):
                    LazyVStack(spacing: Sizes.medium) {
                        ForEach(items) { item in
                            FeedCardView(feedItem: item)
                                .onTapGesture {
                                    viewModel.onItemTapped(item)
                                }
                        }
                    }
                    .padding(.top, Sizes.large)
                    .padding(.horizontal, Sizes.small)
                case let .error(errorString):
                    Text("Failed to load:\n\(errorString)")
                        .font(.AppGarden.footnote)
                        .foregroundStyle(Color.AppGarden.error)
                        .padding(.top, Sizes.large)
                }
            }
            .navigationTitle("The App Garden 🪴")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case let .feedDetail(item):
                    FeedDetailView(feedItem: item)
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "e.g. porcupine or forest, bird")
        .onSubmit(of: .search) {
            viewModel.onSearchTapped()
        }
        .onChange(of: viewModel.searchText) { oldValue, newValue in
            if newValue.isEmpty && !isSearching {
                viewModel.onSearchCancelled()
            }
        }
    }
}

#Preview {
    RootView()
}
