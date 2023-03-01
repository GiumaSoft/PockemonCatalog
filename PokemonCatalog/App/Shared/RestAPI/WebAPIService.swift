import Foundation
// swiftlint:disable colon opening_brace

protocol WebAPIService {
    var scheme      : HTTPScheme            { get }
    var host        : String                { get }
    var path        : String                { get }
    var port        : Int                  { get }
    var queryItems  : [URLQueryItem]?       { get }
    var method      : HTTPMethod            { get }
    var headers     : [String: String]      { get }
    var payload     : Data?                 { get }

    var url: URL? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeout: TimeInterval { get }

    func base64EncodedCredentials(user: String, secret: String) throws -> String
}

extension WebAPIService {
    var scheme      : HTTPScheme            { .https }
    var path        : String                { "/" }
    var port        : Int                  { scheme.port }
    var queryItems  : [URLQueryItem]?       { nil }
    var method      : HTTPMethod            { .get }
    var headers     : [String: String]      { [:] }
    var payload     : Data?                 { nil }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme.description
        components.host = host
        components.path = path
        components.port = port
        components.queryItems = queryItems
        return components.url
    }
    var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalCacheData }
    var timeout: TimeInterval { 10 }

// MARK: - Public methods

    // MARK: - base64EncodedCredentials(_:)
    func base64EncodedCredentials(user: String, secret: String) -> String {
        guard let encodedString = String(format: "%@:%@", user, secret).data(using: .utf8) else {
            debugPrint("Basic authentication base64 string failed to generate due to invalid characters in user or secret params")
            return String()
        }
        return encodedString.base64EncodedString()
    }
}
