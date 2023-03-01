import Foundation

enum NavigationDestination: Identifiable {
    case catalog
    case details(Model.Pokemon?)

    var id: String {
        String(describing: self)
    }
}

extension NavigationDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(self)")
    }

    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.catalog, .catalog):
            return true
        case (.details(let lhsType), .details(let rhsType)):
            return lhsType == rhsType
        default:
            return false
        }
    }
}
