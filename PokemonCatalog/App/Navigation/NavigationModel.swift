import SwiftUI

class NavigationModel: ObservableObject {
    @Published var path = [NavigationDestination]()

    enum CodingKeys: String, CodingKey {
       case path
    }

    init() { }

    @ViewBuilder func route(_ destination: NavigationDestination) -> some View {
        switch destination {
        case .catalog:
            PokemonCatalogView()
        case .details(let model):
            PokemonDetailsView(model: model)
        }
    }
}
