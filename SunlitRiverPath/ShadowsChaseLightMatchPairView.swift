import SwiftUI

struct ShadowsChaseLightMatchPairView: View {
    var shadowsChaseLightOnComplete: (Int) -> Void

    private let shadowsChaseLightSymbols = ["🌆", "🎮", "📚", "🏆", "⚙️", "🌙", "✨", "🔮"]
    private let shadowsChaseLightColumns = 4
    private let shadowsChaseLightPairsCount = 8

    @State private var shadowsChaseLightCardIds: [Int] = []
    @State private var shadowsChaseLightFlipped: Set<Int> = []
    @State private var shadowsChaseLightMatched: Set<Int> = []
    @State private var shadowsChaseLightMoves = 0
    @State private var shadowsChaseLightLastFlipped: [Int] = []
    @State private var shadowsChaseLightLockTaps = false
    @State private var shadowsChaseLightGameWon = false

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Text("Moves: \(shadowsChaseLightMoves)")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                    Spacer()
                }
                .padding(.horizontal, 20)

                if !shadowsChaseLightGameWon {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: shadowsChaseLightColumns), spacing: 10) {
                        ForEach(Array(shadowsChaseLightCardIds.enumerated()), id: \.offset) { index, pairId in
                            ShadowsChaseLightMatchPairCard(
                                shadowsChaseLightSymbol: shadowsChaseLightSymbols[pairId],
                                shadowsChaseLightIsFlipped: shadowsChaseLightFlipped.contains(index) || shadowsChaseLightMatched.contains(pairId),
                                shadowsChaseLightIsMatched: shadowsChaseLightMatched.contains(pairId)
                            ) {
                                shadowsChaseLightTapCard(index: index)
                            }
                            .disabled(shadowsChaseLightLockTaps || shadowsChaseLightMatched.contains(pairId))
                        }
                    }
                    .padding(20)
                }
                Spacer()
            }
            .padding(.top, 20)

            if shadowsChaseLightGameWon {
                ShadowsChaseLightMatchPairWinScreen(
                    shadowsChaseLightMoves: shadowsChaseLightMoves,
                    shadowsChaseLightOnDone: {
                        shadowsChaseLightOnComplete(shadowsChaseLightMoves)
                    }
                )
            }
        }
        .onAppear {
            shadowsChaseLightNewGame()
        }
    }

    private func shadowsChaseLightNewGame() {
        var ids: [Int] = []
        for i in 0..<shadowsChaseLightPairsCount {
            ids.append(i)
            ids.append(i)
        }
        shadowsChaseLightCardIds = ids.shuffled()
        shadowsChaseLightFlipped = []
        shadowsChaseLightMatched = []
        shadowsChaseLightMoves = 0
        shadowsChaseLightLastFlipped = []
        shadowsChaseLightLockTaps = false
        shadowsChaseLightGameWon = false
    }

    private func shadowsChaseLightTapCard(index: Int) {
        if shadowsChaseLightLockTaps || shadowsChaseLightFlipped.contains(index) { return }
        let pairId = shadowsChaseLightCardIds[index]
        if shadowsChaseLightMatched.contains(pairId) { return }

        if shadowsChaseLightLastFlipped.count == 2 {
            shadowsChaseLightLastFlipped = []
        }

        if shadowsChaseLightLastFlipped.isEmpty {
            shadowsChaseLightFlipped.insert(index)
            shadowsChaseLightLastFlipped = [index]
            return
        }

        shadowsChaseLightMoves += 1
        let firstIndex = shadowsChaseLightLastFlipped[0]
        let firstPairId = shadowsChaseLightCardIds[firstIndex]

        if firstPairId == pairId {
            shadowsChaseLightFlipped.insert(index)
            shadowsChaseLightLastFlipped = []
            shadowsChaseLightMatched.insert(pairId)
            shadowsChaseLightFlipped.remove(firstIndex)
            shadowsChaseLightFlipped.remove(index)
            if shadowsChaseLightMatched.count == shadowsChaseLightPairsCount {
                shadowsChaseLightGameWon = true
            }
        } else {
            shadowsChaseLightFlipped.insert(index)
            shadowsChaseLightLockTaps = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                shadowsChaseLightFlipped.remove(firstIndex)
                shadowsChaseLightFlipped.remove(index)
                shadowsChaseLightLastFlipped = []
                shadowsChaseLightLockTaps = false
            }
        }
    }
}

struct ShadowsChaseLightMatchPairCard: View {
    let shadowsChaseLightSymbol: String
    let shadowsChaseLightIsFlipped: Bool
    let shadowsChaseLightIsMatched: Bool
    let shadowsChaseLightOnTap: () -> Void

    var body: some View {
        Button(action: shadowsChaseLightOnTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(ShadowsChaseLightDesign.shadowsChaseLightCardGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(shadowsChaseLightIsMatched ? Color.white.opacity(0.2) : Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(shadowsChaseLightIsFlipped ? ShadowsChaseLightDesign.shadowsChaseLightAccent.opacity(0.6) : ShadowsChaseLightDesign.shadowsChaseLightGlassStroke, lineWidth: 1)
                    )
                if shadowsChaseLightIsFlipped {
                    Text(shadowsChaseLightSymbol)
                        .font(.system(size: 28, weight: .regular, design: .rounded))
                } else {
                    Image(systemName: "questionmark")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                }
            }
            .aspectRatio(0.85, contentMode: .fit)
        }
        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
    }
}

struct ShadowsChaseLightMatchPairWinScreen: View {
    let shadowsChaseLightMoves: Int
    let shadowsChaseLightOnDone: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [ShadowsChaseLightDesign.shadowsChaseLightAccent, ShadowsChaseLightDesign.shadowsChaseLightAccent.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.bottom, 8)
                Text("You won!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                Text("Completed in \(shadowsChaseLightMoves) moves")
                    .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                Button(action: shadowsChaseLightOnDone) {
                    Text("Done")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                }
                .background(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                .clipShape(Capsule())
                .padding(.top, 16)
            }
            .padding(32)
            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 24))
            .padding(40)
        }
    }
}
