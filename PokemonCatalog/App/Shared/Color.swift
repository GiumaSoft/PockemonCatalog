import SwiftUI

extension Color {
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }

    static let primaryForeground = Color.white
    static let gold = Color(.displayP3, red: 0xd7/255, green: 0xbe/255, blue: 0x69/255, opacity: 1)
}
