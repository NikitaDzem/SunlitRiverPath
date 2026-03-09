import SwiftUI

struct ShadowsChaseLightRememberSequenceView: View {
    var shadowsChaseLightOnComplete: (Int) -> Void

    private let shadowsChaseLightColors: [Color] = [
        Color(red: 1, green: 0.3, blue: 0.2),
        Color(red: 0.2, green: 0.8, blue: 0.4),
        Color(red: 0.2, green: 0.4, blue: 1),
        Color(red: 0.9, green: 0.75, blue: 0.1)
    ]

    @State private var shadowsChaseLightSequence: [Int] = []
    @State private var shadowsChaseLightUserStep = 0
    @State private var shadowsChaseLightLevel = 1
    @State private var shadowsChaseLightPhase: ShadowsChaseLightSequencePhase = .playing
    @State private var shadowsChaseLightHighlightIndex: Int? = nil
    @State private var shadowsChaseLightGameOver = false

    enum ShadowsChaseLightSequencePhase {
        case playing
        case userTurn
        case gameOver
    }

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Text("Level \(shadowsChaseLightLevel)")
                    .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                if shadowsChaseLightPhase == .userTurn {
                    Text("Your turn")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                }
                if shadowsChaseLightPhase == .playing {
                    Text("Watch the sequence")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                }

                if shadowsChaseLightGameOver {
                    ShadowsChaseLightRememberSequenceWinScreen(
                        shadowsChaseLightLevel: shadowsChaseLightLevel,
                        shadowsChaseLightOnDone: {
                            shadowsChaseLightOnComplete(shadowsChaseLightLevel)
                        }
                    )
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(0..<4, id: \.self) { index in
                            Button {
                                shadowsChaseLightTapButton(index: index)
                            } label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(shadowsChaseLightColors[index])
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(shadowsChaseLightHighlightIndex == index ? Color.white.opacity(0.5) : Color.clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(shadowsChaseLightHighlightIndex == index ? Color.white : Color.clear, lineWidth: 4)
                                    )
                                    .aspectRatio(1, contentMode: .fit)
                            }
                            .disabled(shadowsChaseLightPhase != .userTurn)
                            .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        }
                    }
                    .padding(24)
                }
                Spacer()
            }
            .padding(.top, 20)
        }
        .onAppear {
            shadowsChaseLightStartLevel()
        }
    }

    private func shadowsChaseLightStartLevel() {
        shadowsChaseLightSequence.append(Int.random(in: 0...3))
        shadowsChaseLightUserStep = 0
        shadowsChaseLightPhase = .playing
        shadowsChaseLightPlaySequence(index: 0)
    }

    private func shadowsChaseLightPlaySequence(index: Int) {
        guard index < shadowsChaseLightSequence.count else {
            shadowsChaseLightPhase = .userTurn
            return
        }
        let idx = shadowsChaseLightSequence[index]
        shadowsChaseLightHighlightIndex = idx
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            shadowsChaseLightHighlightIndex = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                shadowsChaseLightPlaySequence(index: index + 1)
            }
        }
    }

    private func shadowsChaseLightTapButton(index: Int) {
        guard shadowsChaseLightPhase == .userTurn else { return }
        if index != shadowsChaseLightSequence[shadowsChaseLightUserStep] {
            shadowsChaseLightPhase = .gameOver
            shadowsChaseLightGameOver = true
            return
        }
        shadowsChaseLightUserStep += 1
        if shadowsChaseLightUserStep == shadowsChaseLightSequence.count {
            shadowsChaseLightLevel += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                shadowsChaseLightStartLevel()
            }
        }
    }
}

struct ShadowsChaseLightRememberSequenceWinScreen: View {
    let shadowsChaseLightLevel: Int
    let shadowsChaseLightOnDone: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 56))
                .foregroundStyle(
                    LinearGradient(
                        colors: [ShadowsChaseLightDesign.shadowsChaseLightAccent, ShadowsChaseLightDesign.shadowsChaseLightAccent.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            Text("Reached level \(shadowsChaseLightLevel)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
            Text("Coins earned for this run. Tap Done to collect.")
                .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button(action: shadowsChaseLightOnDone) {
                Text("Done")
                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
            }
            .background(ShadowsChaseLightDesign.shadowsChaseLightAccent)
            .clipShape(Capsule())
            .padding(.top, 8)
        }
        .padding(32)
        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 24))
        .padding(40)
    }
}
