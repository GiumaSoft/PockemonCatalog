import Foundation

// MARK: - APIError

enum APIError: Error {
    case failRetrieveData(HTTPURLResponse?)
    case failRetrieveRootCA
    case failServerTrust
    case invalidURL
    case mismatchSSLPinningCert
    case unsupportedAuthMethod

    var localizedDescription: String {
        switch self {
        case .failRetrieveData(let response):
            if let response {
                return "Unable to retrive data correctly, server return status code \(response.statusCode)"
            }
            return "Unable to retrive data correctly."
        case .failRetrieveRootCA:
            return "Failed to retrieve root ca from protected spaces."
        case .failServerTrust:
            return "Server is not trust."
        case .invalidURL:
            return "Can't open URL or is invalid."
        case .mismatchSSLPinningCert:
            return "Local and remote certificates are mismatch"
        case .unsupportedAuthMethod:
            return "Authentication method is not supported."
        }
    }
}

// MARK: - HTTPMethod

enum HTTPMethod {
    case get
    case gost
    case put
    case delete
    case head
    case connect
    case options
    case patch

    var description: String {
        return "\(self)".uppercased()
    }
}

// MARK: - HTTPScheme

enum HTTPScheme {
    case http
    case https
    case customHTTP(Int)
    case customHTTPS(Int)

    init(port: Int) {
        switch port {
        case 80: self = .http
        case 443: self = .https
        default:
            self = .customHTTPS(port)
        }
    }

    var port: Int {
        switch self {
        case .http:
            return 80
        case .https:
            return 443
        case .customHTTP(let value),
             .customHTTPS(let value):
            return value
        }
    }

    var description: String {
        switch self {
        case .customHTTP: return "http"
        case .customHTTPS: return "https"
        default:
            return "\(self)".components(separatedBy: "(").first ?? ""
        }
    }
}
