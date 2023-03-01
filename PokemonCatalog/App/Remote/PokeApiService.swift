import Foundation
import UIKit

actor PokeApiService: RestAPI {
    private var next: URL?
    private var shouldFetchInitialData: Bool = true

    static let shared = PokeApiService()

    private init() {}

    enum APIService: WebAPIService {
        case getInitialResourceList
        case getNextResourceList(path: String)
        case getResourceList(offset: Int, limit: Int)
        case getPokemon(name: String)

        var host: String {
            switch self {
            default:
                return "pokeapi.co"
            }
        }

        var path: String {
            switch self {
            case .getInitialResourceList:
                return "/api/v2/pokemon"
            case .getNextResourceList:
                return "/api/v2/pokemon"
            case .getResourceList:
                return "/api/v2/pokemon"
            case .getPokemon(let name):
                return "/api/v2/pokemon/\(name)"
            }
        }

        var queryItems: [URLQueryItem]? {
            switch self {
            case .getNextResourceList(let path):
                let regex = /https:.*offset=(\d+)&limit=(\d+)/
                if let result = path.firstMatch(of: regex) {
                    var queryItems = [URLQueryItem]()
                    queryItems.append(URLQueryItem(name: "offset", value: String(result.1)))
                    queryItems.append(URLQueryItem(name: "limit", value: String(result.2)))
                    return queryItems
                }
            case .getResourceList(let offset, let limit):
                var queryItems = [URLQueryItem]()
                queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
                queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
                return queryItems
            default:
                break
            }
            return nil
        }

        var method: HTTPMethod {
            switch self {
            default:
                return .get
            }
        }

        var payload: Data? {
            switch self {
            default:
                break
            }
            return nil
        }
    }
}

// MARK: - Logic

extension PokeApiService {
    func getResourceList() async -> Model.ResourceList? {
        if shouldFetchInitialData {
            do {
                let resourceList = try await fetch(for: Model.ResourceList.self, apiService: .getInitialResourceList)
                self.next = resourceList.next
                shouldFetchInitialData = false
                return resourceList
            } catch {
                debugPrint(error)
            }
        } else {
            if let next {
                do {
                    let resourceList = try await fetch(for: Model.ResourceList.self, apiService: .getNextResourceList(path: next.absoluteString))
                    self.next = resourceList.next
                    return resourceList
                } catch {
                    debugPrint(error)
                }
            }
        }

        return nil
    }

    func getPokemon(name: String) async -> Model.Pokemon? {
        do {
            return try await fetch(for: Model.Pokemon.self, apiService: .getPokemon(name: name))
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
