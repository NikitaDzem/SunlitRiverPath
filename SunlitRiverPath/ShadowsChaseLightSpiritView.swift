import SwiftUI

struct ShadowsChaseLightSpiritView: View {
    @StateObject private var shadowsChaseLightSpiritVM = ShadowsChaseLightSpiritViewModel()
    @State private var shadowsChaseLightShowingExtraction = false
    @State private var shadowsChaseLightShowingAchievements = false
    @State private var shadowsChaseLightShowingQuiz = false

    private var shadowsChaseLightCanSell: Bool {
        shadowsChaseLightSpiritVM.shadowsChaseLightWaterCount >= 1
    }

    private var shadowsChaseLightSellTotal: Int {
        shadowsChaseLightSpiritVM.shadowsChaseLightWaterCount * ShadowsChaseLightSpiritViewModel.shadowsChaseLightWaterPricePerUnit
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("💧 Extract water from the lake and sell it for coins. Coins go to your Shop balance.")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 4)

                        ZStack {
                            ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 20)
                            VStack(spacing: 12) {
                                Text("🌊")
                                    .font(.system(size: 52))
                                Text("The Lake")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                Text("Extract water here, then sell it.")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            }
                            .padding(24)
                        }
                        .padding(.horizontal, 16)

                        VStack(spacing: 8) {
                            Text("💧")
                                .font(.system(size: 36))
                            Text("Water")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            Text("\(shadowsChaseLightSpiritVM.shadowsChaseLightWaterCount)")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        .padding(.horizontal, 16)

                        Button(action: { shadowsChaseLightShowingExtraction = true }) {
                            HStack(spacing: 12) {
                                Text("⬇️")
                                    .font(.system(size: 22))
                                Text("Extract water")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                    .lineLimit(1)
                            }
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton())
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        .padding(.horizontal, 16)

                        Button(action: { shadowsChaseLightSpiritVM.shadowsChaseLightSellWater() }) {
                            HStack(spacing: 12) {
                                Text("💰")
                                    .font(.system(size: 22))
                                Text("Sell all water")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                    .lineLimit(1)
                                if shadowsChaseLightSpiritVM.shadowsChaseLightWaterCount > 0 {
                                    Text("(\(shadowsChaseLightSellTotal) coins)")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                }
                            }
                            .foregroundColor(shadowsChaseLightCanSell ? ShadowsChaseLightDesign.shadowsChaseLightTextPrimary : ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background {
                                if shadowsChaseLightCanSell {
                                    ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton()
                                } else {
                                    RoundedRectangle(cornerRadius: 14).fill(Color(red: 0.1, green: 0.18, blue: 0.28))
                                }
                            }
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        .disabled(!shadowsChaseLightCanSell)
                        .padding(.horizontal, 16)

                        Button(action: { shadowsChaseLightShowingAchievements = true }) {
                            HStack(spacing: 12) {
                                Text("🏆")
                                    .font(.system(size: 22))
                                Text("Achievements")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                    .lineLimit(1)
                            }
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton())
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        .padding(.horizontal, 16)

                        Button(action: { shadowsChaseLightShowingQuiz = true }) {
                            HStack(spacing: 12) {
                                Text("📝")
                                    .font(.system(size: 22))
                                Text("Quiz")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                    .lineLimit(1)
                            }
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton())
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 20)
                }
            }
            .navigationTitle("🌊 Spirit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient, for: .navigationBar)
            .onAppear {
                shadowsChaseLightSpiritVM.shadowsChaseLightRefresh()
            }
            .fullScreenCover(isPresented: $shadowsChaseLightShowingExtraction) {
                ShadowsChaseLightExtractionAnimationView(shadowsChaseLightOnComplete: {
                    shadowsChaseLightSpiritVM.shadowsChaseLightAddWater(10)
                    shadowsChaseLightShowingExtraction = false
                })
            }
            .fullScreenCover(isPresented: $shadowsChaseLightShowingAchievements) {
                ShadowsChaseLightAchievementsView(shadowsChaseLightOnDismiss: { shadowsChaseLightShowingAchievements = false })
            }
            .fullScreenCover(isPresented: $shadowsChaseLightShowingQuiz) {
                ShadowsChaseLightQuizView(shadowsChaseLightOnComplete: { shadowsChaseLightShowingQuiz = false })
            }
        }
    }
}
