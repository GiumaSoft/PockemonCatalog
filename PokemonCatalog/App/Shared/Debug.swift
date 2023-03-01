import Foundation

func debugPrint(_ error: Error, file: String? = nil) {
    switch error {
    case let decodingError as DecodingError:
        switch decodingError {
        case .keyNotFound(let key, let context):
            debugPrint("Failed to decode\(file == nil ? " " : " \(file!) from bundle ")due to key '\(key)' not found - \(context.debugDescription)")
            debugPrint("codingPath:", context.codingPath)
        case .valueNotFound(let value, let context):
            debugPrint("Failed to decode\(file == nil ? " " : " \(file!) from bundle ")due to missing '\(value)' - \(context.debugDescription)")
            debugPrint("codingPath:", context.codingPath)
        case .typeMismatch(_, let context):
            debugPrint("Failed to decode\(file == nil ? " " : " \(file!) from bundle ")due to type mismatch - \(context.debugDescription)")
            debugPrint("codingPath:", context.codingPath)
        case .dataCorrupted(let context):
            debugPrint("Failed to decode\(file == nil ? " " : " \(file!) from bundle ")because it appears to be invalid JSON")
            debugPrint("codingPath:", context.codingPath)
        default:
            break
        }

    case let error as NSError:
        debugPrint(error.localizedDescription)
        if let localizedFailureReason = error.localizedFailureReason {
            debugPrint(localizedFailureReason)
        }
        if let localizedRecoveryOptions = error.localizedRecoveryOptions {
            debugPrint(localizedRecoveryOptions)
        }
        if let localizedRecoverySuggestion = error.localizedRecoverySuggestion {
            debugPrint(localizedRecoverySuggestion)
        }
    }
}

func debugPrint(_ apiError: APIError) {
    debugPrint(apiError.localizedDescription)
}

func debugPrint(_ response: URLResponse, data: Data?) {
    switch response {
    case let response as HTTPURLResponse:
        debugPrint("Server response code = \(response.statusCode), ", HTTPURLResponse.localizedString(forStatusCode: response.statusCode))
        if let url = response.url { debugPrint("URL:", url) }
        debugPrint("Headers\n{")
        for (key, value) in response.allHeaderFields {
            debugPrint("  \(key) = \(value)")
        }
        debugPrint("}")
        if let data = data {
            debugPrint("Body")
            debugPrint(String(decoding: data, as: UTF8.self))
            debugPrint(data.count, "bytes")
        }
    default:
        break
    }
}

func debugPrint(data: Data?) {
    if let data, data.count > 0 {
        debugPrint(String(decoding: data, as: UTF8.self))
        debugPrint(data.count, "bytes")
    }
}
