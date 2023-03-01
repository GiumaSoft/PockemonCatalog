import Foundation

extension String {
    var localizedError: String {
        NSLocalizedString(self, tableName: "Error.strings", bundle: .main, comment: "")
    }
}
