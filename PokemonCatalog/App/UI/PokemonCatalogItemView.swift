import SwiftUI

// MARK: CatalogItemView

struct PokemonCatalogItemView {
    @EnvironmentObject var navModel: NavigationModel

    @State private var imageURL: URL?
    @State private var detailsModel: Model.Pokemon?
    let id: Int
    let name: String
    let cardBackgroundColor: Color
}

extension PokemonCatalogItemView {
    init(from model: Model.Pokemon) {
        self._detailsModel = State<Model.Pokemon?>(initialValue: model)
        self.id = model.id
        self.name = model.name
        self.cardBackgroundColor = .random
    }
}

// MARK: - View

extension PokemonCatalogItemView: View {
    var body: some View {
        HStack(spacing: .spacing4x) {
            imageAndName
            Spacer()
        }
        .task {
            guard let pokemon = await service.getPokemon(name: name) else { return }
            self.detailsModel = pokemon
            self.imageURL = pokemon.sprites.frontDefault
        }
        .padding()
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: .sizing4x)
                .fill(cardBackgroundColor)
        )
        .onTapGesture {
            navModel.path.append(.details(detailsModel))
        }
    }

    private var imageAndName: some View {
        Group {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .frame(width: .sizing18x, height: .sizing18x)
            } placeholder: {
                RoundedRectangle(cornerRadius: .sizing4x)
                    .foregroundColor(Color.primaryForeground)
                    .frame(width: .sizing18x, height: .sizing18x)
            }
            .background(
                RoundedRectangle(cornerRadius: .sizing4x)
                    .fill(Color.primaryForeground)
            )
            .overlay {
                RoundedRectangle(cornerRadius: .sizing4x)
                    .strokeBorder(Color.gold, lineWidth: .sizing0xQuarter, antialiased: true)
            }

            Text(name.capitalized)
                .font(.system(size: .sizing7x, weight: .bold, design: .rounded))
        }
    }
}

// MARK: - Logic

extension PokemonCatalogItemView {
    private var service: PokeApiService { PokeApiService.shared }
}

// MARK: - DataModel

struct PokemonCatalogItem: Hashable {
    let pokemonName: String
    let cardBackgroundColor = Color.random

    init(pokemonName: String) {
        self.pokemonName = pokemonName
    }
}
