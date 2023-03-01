import Foundation

enum FileError: Error {
    case missing, unreadable
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type,
                              resource: Resource.Mock,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) throws -> T {
        try decode(type, from: resource.rawValue)
    }

    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            debugPrint("Failed to locate \(file) in bundle.")
            throw FileError.missing
        }

        guard let data = try? Data(contentsOf: url) else {
            debugPrint("Failed to load \(file) from bundle.")
            throw FileError.unreadable
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint(error, file)
            throw error
        }
    }
}
