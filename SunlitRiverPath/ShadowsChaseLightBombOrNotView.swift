import SwiftUI

struct ShadowsChaseLightBombOrNotView: View {
    var shadowsChaseLightOnComplete: (Int) -> Void

    private let shadowsChaseLightPrizeValues = [5, 15, 25, 35, 50]
    private let shadowsChaseLightTotalCards = 10
    private let shadowsChaseLightBombCount = 5

    @State private var shadowsChaseLightCards: [ShadowsChaseLightBombOrNotCardItem] = []
    @State private var shadowsChaseLightSelectedIndex: Int? = nil
    @State private var shadowsChaseLightRevealed = false
    @State private var shadowsChaseLightShowResult = false

    struct ShadowsChaseLightBombOrNotCardItem: Identifiable {
        let id: Int
        let shadowsChaseLightIsBomb: Bool
        let shadowsChaseLightPrize: Int
    }

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Text("Pick one card")
                    .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                Text("5 bombs = nothing. 5 cards = 5–50 coins.")
                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if shadowsChaseLightShowResult, let idx = shadowsChaseLightSelectedIndex, idx < shadowsChaseLightCards.count {
                    let item = shadowsChaseLightCards[idx]
                    VStack(spacing: 16) {
                        if item.shadowsChaseLightIsBomb {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 56))
                                .foregroundColor(.orange)
                            Text("Bomb!")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                            Text("No coins this time")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        } else {
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 56))
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            Text("+\(item.shadowsChaseLightPrize) coins")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        }
                        Button("Done") {
                            shadowsChaseLightOnComplete(item.shadowsChaseLightIsBomb ? 0 : item.shadowsChaseLightPrize)
                        }
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        .clipShape(Capsule())
                        .padding(.top, 8)
                    }
                    .padding(32)
                    .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 24))
                    .padding(.horizontal, 24)
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 5), spacing: 10) {
                        ForEach(Array(shadowsChaseLightCards.enumerated()), id: \.element.id) { index, item in
                            Button {
                                guard !shadowsChaseLightRevealed else { return }
                                shadowsChaseLightRevealed = true
                                shadowsChaseLightSelectedIndex = index
                                shadowsChaseLightShowResult = true
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(ShadowsChaseLightDesign.shadowsChaseLightCardGradient)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(ShadowsChaseLightDesign.shadowsChaseLightGlassStroke, lineWidth: 1)
                                        )
                                    Image(systemName: "questionmark")
                                        .font(.system(size: 22, weight: .medium))
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                }
                                .aspectRatio(0.9, contentMode: .fit)
                            }
                            .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                            .disabled(shadowsChaseLightRevealed)
                        }
                    }
                    .padding(20)
                }
                Spacer()
            }
            .padding(.top, 24)
        }
        .onAppear {
            shadowsChaseLightSetupCards()
        }
    }

    private func shadowsChaseLightSetupCards() {
        var list: [ShadowsChaseLightBombOrNotCardItem] = []
        for i in 0..<shadowsChaseLightBombCount {
            list.append(ShadowsChaseLightBombOrNotCardItem(id: i, shadowsChaseLightIsBomb: true, shadowsChaseLightPrize: 0))
        }
        for (i, value) in shadowsChaseLightPrizeValues.enumerated() {
            list.append(ShadowsChaseLightBombOrNotCardItem(id: shadowsChaseLightBombCount + i, shadowsChaseLightIsBomb: false, shadowsChaseLightPrize: value))
        }
        shadowsChaseLightCards = list.shuffled()
    }
}
