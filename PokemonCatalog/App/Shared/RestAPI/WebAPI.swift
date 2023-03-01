import Foundation

// MARK: - WebAPI

protocol WebAPI {
    associatedtype APIService: WebAPIService

    var delegate: URLSessionTaskDelegate? { get }
    var configuration: URLSessionConfiguration { get }

    func fetch(apiService: APIService) async throws -> Data
    func fetch(request: URLRequest) async throws -> Data
}

extension WebAPI {
    var delegate: URLSessionTaskDelegate? { nil }
    var configuration: URLSessionConfiguration { .default }

    func fetch(apiService: APIService) async throws -> Data {
        guard let url = apiService.url else {
            debugPrint(.invalidURL)
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url,
                                 cachePolicy: apiService.cachePolicy,
                                 timeoutInterval: apiService.timeout)

        request.httpMethod = apiService.method.description
        request.allHTTPHeaderFields = apiService.headers
        request.httpBody = apiService.payload

        return try await fetch(request: request)
    }

    func fetch(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession(configuration: configuration).data(for: request, delegate: delegate)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            debugPrint(response, data: data)
            throw APIError.failRetrieveData(response as? HTTPURLResponse)
        }
        return data
    }
}
