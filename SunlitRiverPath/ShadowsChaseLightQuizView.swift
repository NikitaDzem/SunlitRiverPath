import SwiftUI

struct ShadowsChaseLightQuizView: View {
    var shadowsChaseLightOnComplete: () -> Void

    @State private var shadowsChaseLightQuestions: [ShadowsChaseLightQuizQuestion] = []
    @State private var shadowsChaseLightCurrentIndex = 0
    @State private var shadowsChaseLightSelectedIndex: Int? = nil
    @State private var shadowsChaseLightCorrectCount = 0
    @State private var shadowsChaseLightShowingResult = false
    @State private var shadowsChaseLightShowCompletion = false

    private var shadowsChaseLightCurrentQuestion: ShadowsChaseLightQuizQuestion? {
        guard shadowsChaseLightCurrentIndex < shadowsChaseLightQuestions.count else { return nil }
        return shadowsChaseLightQuestions[shadowsChaseLightCurrentIndex]
    }

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()

            if shadowsChaseLightShowCompletion {
                ShadowsChaseLightQuizCompletionView(
                    shadowsChaseLightCorrect: shadowsChaseLightCorrectCount,
                    shadowsChaseLightTotal: shadowsChaseLightQuestions.count,
                    shadowsChaseLightOnDismiss: shadowsChaseLightOnComplete
                )
            } else if let q = shadowsChaseLightCurrentQuestion {
                VStack(spacing: 24) {
                    Text("Question \(shadowsChaseLightCurrentIndex + 1)/\(shadowsChaseLightQuestions.count)")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                    Text(q.shadowsChaseLightQuestion)
                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    VStack(spacing: 12) {
                        ForEach(0..<q.shadowsChaseLightOptions.count, id: \.self) { i in
                            Button {
                                if shadowsChaseLightSelectedIndex == nil {
                                    shadowsChaseLightSelectedIndex = i
                                    if i == q.shadowsChaseLightCorrectIndex {
                                        shadowsChaseLightCorrectCount += 1
                                    }
                                    shadowsChaseLightShowingResult = true
                                }
                            } label: {
                                HStack {
                                    Text(q.shadowsChaseLightOptions[i])
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    if shadowsChaseLightSelectedIndex != nil {
                                        if i == q.shadowsChaseLightCorrectIndex {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                        } else if i == shadowsChaseLightSelectedIndex && i != q.shadowsChaseLightCorrectIndex {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(optionBackground(for: i, question: q))
                            }
                            .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                            .disabled(shadowsChaseLightSelectedIndex != nil)
                        }
                    }
                    .padding(.horizontal, 24)

                    if shadowsChaseLightShowingResult {
                        Button("Next") {
                            shadowsChaseLightSelectedIndex = nil
                            shadowsChaseLightShowingResult = false
                            shadowsChaseLightCurrentIndex += 1
                            if shadowsChaseLightCurrentIndex >= shadowsChaseLightQuestions.count {
                                shadowsChaseLightShowCompletion = true
                            }
                        }
                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightPrimaryButton(enabled: true))
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }
                    Spacer()
                }
                .padding(.top, 40)
            }
        }
        .onAppear {
            if shadowsChaseLightQuestions.isEmpty {
                shadowsChaseLightQuestions = ShadowsChaseLightQuizData.shadowsChaseLightPick10Random()
            }
        }
    }

    private func optionBackground(for index: Int, question: ShadowsChaseLightQuizQuestion) -> some View {
        guard let selected = shadowsChaseLightSelectedIndex else {
            return AnyView(ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton())
        }
        if index == question.shadowsChaseLightCorrectIndex {
            return AnyView(RoundedRectangle(cornerRadius: 14).fill(Color.green.opacity(0.3)).overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.green, lineWidth: 2)))
        }
        if index == selected && index != question.shadowsChaseLightCorrectIndex {
            return AnyView(RoundedRectangle(cornerRadius: 14).fill(Color.red.opacity(0.2)).overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.red, lineWidth: 2)))
        }
        return AnyView(ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton())
    }
}

struct ShadowsChaseLightQuizCompletionView: View {
    let shadowsChaseLightCorrect: Int
    let shadowsChaseLightTotal: Int
    var shadowsChaseLightOnDismiss: () -> Void

    private var shadowsChaseLightWrong: Int { shadowsChaseLightTotal - shadowsChaseLightCorrect }
    private static let shadowsChaseLightXPPerCorrect = 10
    private static let shadowsChaseLightCoinsPerCorrect = 5

    @State private var shadowsChaseLightXP = 0
    @State private var shadowsChaseLightCoins = 0
    @State private var shadowsChaseLightSaved = false

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 28) {
                Text("📝 Quiz Complete!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                VStack(spacing: 16) {
                    HStack(spacing: 24) {
                        VStack(spacing: 4) {
                            Text("\(shadowsChaseLightCorrect)")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.green)
                            Text("Correct")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        }
                        VStack(spacing: 4) {
                            Text("\(shadowsChaseLightWrong)")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                            Text("Wrong")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity)
                    .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 20))

                    VStack(spacing: 12) {
                        HStack {
                            Text("⭐ XP earned")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            Spacer()
                            Text("+\(shadowsChaseLightXP)")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        }
                        HStack {
                            Text("💰 Coins earned")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            Spacer()
                            Text("+\(shadowsChaseLightCoins)")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        }
                    }
                    .padding(20)
                    .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                }
                .padding(.horizontal, 24)

                Button("Done") {
                    shadowsChaseLightOnDismiss()
                }
                .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(ShadowsChaseLightDesign.shadowsChaseLightPrimaryButton(enabled: true))
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            shadowsChaseLightXP = shadowsChaseLightCorrect * Self.shadowsChaseLightXPPerCorrect
            shadowsChaseLightCoins = shadowsChaseLightCorrect * Self.shadowsChaseLightCoinsPerCorrect
            guard !shadowsChaseLightSaved else { return }
            shadowsChaseLightSaved = true
            let store = ShadowsChaseLightStorage()
            let keys = ShadowsChaseLightStorageKeys.self
            let attempts = store.shadowsChaseLightReadInt(key: keys.shadowsChaseLightQuizAttempts, default: 0) + 1
            let totalCorrect = store.shadowsChaseLightReadInt(key: keys.shadowsChaseLightQuizTotalCorrect, default: 0) + shadowsChaseLightCorrect
            let xpTotal = store.shadowsChaseLightReadInt(key: keys.shadowsChaseLightTotalXP, default: 0) + shadowsChaseLightXP
            store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightQuizAttempts, value: attempts)
            store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightQuizTotalCorrect, value: totalCorrect)
            store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightQuizLastCorrect, value: shadowsChaseLightCorrect)
            store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightQuizLastTotal, value: shadowsChaseLightTotal)
            if shadowsChaseLightCorrect == shadowsChaseLightTotal && shadowsChaseLightTotal == 10 {
                store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightQuizPerfectCount, value: 1)
            }
            store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightTotalXP, value: xpTotal)
            let balance = store.shadowsChaseLightReadInt(key: keys.shadowsChaseLightShopBalance)
            store.shadowsChaseLightWriteInt(key: keys.shadowsChaseLightShopBalance, value: balance + shadowsChaseLightCoins)
        }
    }
}
