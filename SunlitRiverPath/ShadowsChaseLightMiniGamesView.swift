import SwiftUI

struct ShadowsChaseLightMiniGamesView: View {
    @StateObject private var shadowsChaseLightMiniGamesVM = ShadowsChaseLightMiniGamesViewModel()
    @State private var shadowsChaseLightShowingMatchPair = false
    @State private var shadowsChaseLightShowingRememberSequence = false
    @State private var shadowsChaseLightShowingBombOrNot = false

    var body: some View {
        NavigationStack {
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        Text("Earn coins by playing. Rewards are added to your Shop balance.")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 8)

                        Button(action: { shadowsChaseLightShowingMatchPair = true }) {
                            HStack(spacing: 16) {
                                Text("🃏")
                                    .font(.system(size: 40))
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Match the Pair")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                    Text("Find all matching pairs of symbols")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                    Text("+coins per game (fewer moves = more coins)")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Best")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                    Text(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightMatchPairBestMoves == 999 ? "—" : "\(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightMatchPairBestMoves) moves")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                }
                                Text("\(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightMatchPairGamesWon) won")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            }
                            .padding(20)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())

                        Button(action: { shadowsChaseLightShowingRememberSequence = true }) {
                            HStack(spacing: 16) {
                                Text("🧠")
                                    .font(.system(size: 40))
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Remember the Sequence")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                    Text("Watch the lights, then repeat the sequence")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                    Text("+coins per level reached")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Best")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                    Text(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightRememberSequenceBestLevel == 0 ? "—" : "Level \(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightRememberSequenceBestLevel)")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                }
                                Text("\(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightRememberSequenceGamesWon) played")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            }
                            .padding(20)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())

                        Button(action: { shadowsChaseLightShowingBombOrNot = true }) {
                            HStack(spacing: 16) {
                                Text("💣")
                                    .font(.system(size: 40))
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Bomb or Not")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                    Text("10 cards: 5 bombs, 5 prizes (5–50 coins)")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                    Text("Pick one card. Bomb = nothing, prize = coins.")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                }
                                Spacer()
                                Text("\(shadowsChaseLightMiniGamesVM.shadowsChaseLightProgress.shadowsChaseLightBombOrNotGamesPlayed ?? 0) played")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            }
                            .padding(20)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                    }
                    .padding(20)
                }
            }
            .navigationTitle("🎮 Mini-Games")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient, for: .navigationBar)
            .fullScreenCover(isPresented: $shadowsChaseLightShowingMatchPair) {
                ShadowsChaseLightMatchPairView(shadowsChaseLightOnComplete: { moves in
                    shadowsChaseLightMiniGamesVM.shadowsChaseLightUpdateMatchPair(moves: moves)
                    shadowsChaseLightShowingMatchPair = false
                })
            }
            .fullScreenCover(isPresented: $shadowsChaseLightShowingRememberSequence) {
                ShadowsChaseLightRememberSequenceView(shadowsChaseLightOnComplete: { level in
                    shadowsChaseLightMiniGamesVM.shadowsChaseLightUpdateRememberSequence(level: level)
                    shadowsChaseLightShowingRememberSequence = false
                })
            }
            .fullScreenCover(isPresented: $shadowsChaseLightShowingBombOrNot) {
                ShadowsChaseLightBombOrNotView(shadowsChaseLightOnComplete: { coins in
                    shadowsChaseLightMiniGamesVM.shadowsChaseLightUpdateBombOrNot(coinsWon: coins)
                    shadowsChaseLightShowingBombOrNot = false
                })
            }
        }
    }
}
