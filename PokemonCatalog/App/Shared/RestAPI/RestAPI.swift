import Foundation

protocol RestAPI: WebAPI {
    func fetch<T: Decodable>(for: T.Type, apiService: APIService) async throws -> T
    func fetch<T: Decodable>(for: T.Type, request: URLRequest) async throws -> T
}

extension RestAPI {
    func fetch<T: Decodable>(for: T.Type, apiService: APIService) async throws -> T {
        try decode(
            try await fetch(apiService: apiService)
        )
    }

    func fetch<T: Decodable>(for: T.Type, request: URLRequest) async throws -> T {
        try decode(
            try await fetch(request: request)
        )
    }

    private func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            debugPrint(error)
            debugPrint("Provider returned encoded data")
            debugPrint(data: data)
            throw error
        }
    }
}
