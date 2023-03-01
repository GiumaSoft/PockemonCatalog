import SwiftUI

struct PokemonDetailsView: View {
    let model: Model.Pokemon!

    var body: some View {
        if let model {
            ScrollView {
                portraitName
                VStack {
                    ForEach(Array(model.stats.enumerated()), id: \.0) { _, stat in
                        statCard(stat)
                    }
                }
            }
            .padding()
        }
    }

    private var portraitName: some View {
        HStack(spacing: .spacing3x) {
            AsyncImage(url: model.sprites.frontDefault) { image in
                image
                    .resizable()
                    .frame(width: .sizing24x, height: .sizing24x)
            } placeholder: {
                RoundedRectangle(cornerRadius: .sizing4x)
                    .foregroundColor(Color.primaryForeground)
                    .frame(width: .sizing18x, height: .sizing18x)
            }
            .background(
                RoundedRectangle(cornerRadius: .sizing4x)
                    .fill(Color.primaryForeground)
            )
            .overlay {
                RoundedRectangle(cornerRadius: .sizing4x)
                    .strokeBorder(Color.gold, lineWidth: .sizing0xQuarter, antialiased: true)
            }

            Text("\(model.name.capitalized)")
                .font(.system(size: .sizing7x, weight: .bold, design: .rounded))

            Spacer()
        }
    }

    private func statCard(_ stat: Model.PokemonStat) -> some View {
        VStack {
            HStack {
                Text("\(stat.stat.name)")
                Spacer()
            }
            HStack {
                ProgressBarView(value: stat.baseStat.cgFloat)
                Text("\(stat.baseStat)")
                Spacer()
            }
        }
    }
}
