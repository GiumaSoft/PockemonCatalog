import SwiftUI

struct PokemonCatalogView {
    @EnvironmentObject var navModel: NavigationModel

    @State private var isFetching = false
    @State private var shouldFetchData = true
    @State var catalog = PokemonCatalog()
    @State var service = PokeApiService.shared
}

extension PokemonCatalogView: View {
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: .spacing2x) {
                ForEach(Array(catalog.items.enumerated()), id: \.0) { (id, item) in
                    PokemonCatalogItemView(id: id, name: item.pokemonName, cardBackgroundColor: item.cardBackgroundColor)
                        .onAppear {
                            Task {
                                await fetchDataIfNeeded()
                            }
                        }
                }
            }
            .padding()
            .task {
                await fetchDataIfNeeded()
            }
            .padding(.top)
        }
        .navigationDestination(for: NavigationDestination.self) { destination in
            navModel.route(destination)
        }
    }
}

// MARK: - Logic

extension PokemonCatalogView {
    private func fetchDataIfNeeded() async {
        if shouldFetchData {
            if isFetching.isFalse {
                isFetching = true
                guard let resourceList = await service.getResourceList() else {
                    shouldFetchData = false
                    return
                }
                if catalog.items.count > 0 {
                    self.catalog.appendResources(resourceList)
                } else {
                    self.catalog = PokemonCatalog(element: resourceList)
                }
                isFetching = false
            } else {
                debugPrint("Service is already fetching data for <ResourceList>")
            }
        } else {
            debugPrint("No more data to fetch for <ResourceList>")
        }
    }
}

// MARK: - DataModel

struct PokemonCatalog {
    var items: [PokemonCatalogItem]

    init(items: [PokemonCatalogItem] = []) {
        self.items = items
    }

    init(element: Model.ResourceList) {
        var items = [PokemonCatalogItem]()
        for result in element.results {
            items.append(PokemonCatalogItem(pokemonName: result.name))
        }
        self.items = items
    }

    @inlinable public mutating func appendResources(_ newElement: Model.ResourceList) {
        var items = [PokemonCatalogItem]()
        for result in newElement.results {
            items.append(PokemonCatalogItem(pokemonName: result.name))
        }
        self.items.append(contentsOf: items)
    }
}
