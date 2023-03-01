import SwiftUI

struct RootView: View {
    @StateObject var navModel = NavigationModel()

    var body: some View {
        NavigationStack(path: $navModel.path) {
            PokemonCatalogView()
                .environmentObject(navModel)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
