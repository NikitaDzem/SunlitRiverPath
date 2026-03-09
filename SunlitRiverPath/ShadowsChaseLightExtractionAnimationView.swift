import SwiftUI
import Combine

struct ShadowsChaseLightExtractionAnimationView: View {
    var shadowsChaseLightOnComplete: () -> Void

    private static let shadowsChaseLightDuration: TimeInterval = 60
    private static let shadowsChaseLightEmojis = ["💧", "🌊", "💦", "⬇️", "💧", "🌊", "💧", "💦", "🌊", "💧", "💦", "⬇️", "💧", "🌊", "💦", "💧", "🌊", "💧", "💦", "🌊", "💧", "💦", "⬇️", "💧", "🌊"]
    private static let shadowsChaseLightCount = 24

    @State private var shadowsChaseLightStartTime = Date()
    @State private var shadowsChaseLightElapsed: TimeInterval = 0
    @State private var shadowsChaseLightFinished = false
    @State private var shadowsChaseLightPositions: [(CGFloat, CGFloat)] = (0..<shadowsChaseLightCount).map { _ in
        (CGFloat.random(in: 0.15...0.85), CGFloat.random(in: 0.2...0.8))
    }
    @State private var shadowsChaseLightPhases: [(Double, Double, Double)] = (0..<shadowsChaseLightCount).map { _ in
        (Double.random(in: 0...6), Double.random(in: 0.4...1.2), Double.random(in: 0.3...1))
    }

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()

                TimelineView(.animation(minimumInterval: 0.025)) { timeline in
                    let t = timeline.date.timeIntervalSince(shadowsChaseLightStartTime)
                    ZStack {
                        ForEach(0..<Self.shadowsChaseLightCount, id: \.self) { i in
                            let pos = shadowsChaseLightPositions[i]
                            let phase = shadowsChaseLightPhases[i]
                            let dx = sin(t * phase.1 + phase.0) * 60
                            let dy = cos(t * phase.2 + phase.0 * 0.7) * 50
                            Text(Self.shadowsChaseLightEmojis[i])
                                .font(.system(size: 26 + CGFloat(i % 4) * 6))
                                .position(x: pos.0 * w + dx, y: pos.1 * h + dy)
                        }
                    }
                }

                VStack {
                    Spacer()
                    Text("⏱️ \(Int(max(0, Self.shadowsChaseLightDuration - shadowsChaseLightElapsed))) sec")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                    ProgressView(value: min(1, shadowsChaseLightElapsed / Self.shadowsChaseLightDuration))
                        .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        .scaleEffect(y: 2)
                        .padding(.horizontal, 40)
                        .padding(.top, 8)
                    Text("Extracting water...")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        .padding(.top, 4)
                    Spacer()
                        .frame(height: 50)
                }
            }
        }
        .onAppear {
            shadowsChaseLightStartTime = Date()
            DispatchQueue.main.asyncAfter(deadline: .now() + Self.shadowsChaseLightDuration) {
                guard !shadowsChaseLightFinished else { return }
                shadowsChaseLightFinished = true
                shadowsChaseLightOnComplete()
            }
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            guard !shadowsChaseLightFinished else { return }
            shadowsChaseLightElapsed = Date().timeIntervalSince(shadowsChaseLightStartTime)
        }
    }
}
