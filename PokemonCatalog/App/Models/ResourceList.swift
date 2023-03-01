import Foundation

extension Model {
    struct ResourceList {
        let count: Int                          /// The total number of resources available from this API.
        let next: URL?                          /// The URL for the next page in the list.
        let previous: URL?                      /// The URL for the previous page in the list.
        let results: [NamedAPIResource]         /// A list of named API resources.

        func sorted(by areInIncreasingOrder: (Model.NamedAPIResource, Model.NamedAPIResource) throws -> Bool) rethrows -> Self {
            Self.init(
                count: self.count,
                next: self.next,
                previous: self.previous,
                results: try self.results.sorted(by: areInIncreasingOrder)
            )
        }
    }
}

extension Model.ResourceList: Decodable {
    enum CodingKeys: CodingKey {
        case count
        case next
        case previous
        case results
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Model.ResourceList.CodingKeys> = try decoder.container(keyedBy: Model.ResourceList.CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: Model.ResourceList.CodingKeys.count)
        self.next = try {
            guard let urlString = try container.decodeIfPresent(String.self, forKey: Model.ResourceList.CodingKeys.next) else { return nil }
            return URL(string: urlString)
        }()
        self.previous = try {
            guard let urlString = try container.decodeIfPresent(String.self, forKey: Model.ResourceList.CodingKeys.previous) else { return nil }
            return URL(string: urlString)
        }()
        self.results = try container.decode([Model.NamedAPIResource].self, forKey: Model.ResourceList.CodingKeys.results)
    }
}
