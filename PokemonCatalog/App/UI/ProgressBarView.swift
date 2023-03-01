import SwiftUI

struct ProgressBarView {
    @State private var showBar = false
    let value: CGFloat
}

extension ProgressBarView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(.systemGray6))
            RoundedRectangle(cornerRadius: 3)
                .fill(.indigo.gradient)
                .frame(width: showBar ? value : 0, alignment: .leading)
                .animation(.easeInOut(duration: 1).repeatCount(1), value: showBar)
        }
        .frame(width: 250, height: 12)
        .onAppear {
            showBar.toggle()
        }
    }
}
