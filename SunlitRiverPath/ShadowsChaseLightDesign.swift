import SwiftUI

enum ShadowsChaseLightDesign {
    static var shadowsChaseLightAccent: Color {
        Color(red: 0.35, green: 0.75, blue: 1)
    }
    static var shadowsChaseLightAccentSoft: Color {
        Color(red: 0.35, green: 0.75, blue: 1).opacity(0.4)
    }
    static var shadowsChaseLightBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.06, green: 0.12, blue: 0.22),
                Color(red: 0.04, green: 0.08, blue: 0.16)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    static var shadowsChaseLightCardGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.2, green: 0.35, blue: 0.5).opacity(0.25),
                Color(red: 0.15, green: 0.25, blue: 0.4).opacity(0.15)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    static var shadowsChaseLightTextPrimary: Color { .white }
    static var shadowsChaseLightTextSecondary: Color { Color(red: 0.75, green: 0.85, blue: 1) }
    static var shadowsChaseLightTextTertiary: Color { Color(red: 0.5, green: 0.65, blue: 0.85) }
    static var shadowsChaseLightGlassStroke: Color {
        Color(red: 0.4, green: 0.6, blue: 0.9).opacity(0.25)
    }
    static func shadowsChaseLightCardBackground(cornerRadius: CGFloat = 16) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(shadowsChaseLightCardGradient)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(shadowsChaseLightGlassStroke, lineWidth: 1)
            )
            .shadow(color: shadowsChaseLightAccent.opacity(0.12), radius: 12, x: 0, y: 4)
            .shadow(color: Color.black.opacity(0.35), radius: 8, x: 0, y: 2)
    }
    static func shadowsChaseLightPrimaryButton(enabled: Bool = true) -> some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(enabled ? shadowsChaseLightAccent : Color(red: 0.3, green: 0.45, blue: 0.6))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(enabled ? shadowsChaseLightAccent.opacity(0.6) : Color.clear, lineWidth: 1)
            )
            .shadow(color: enabled ? shadowsChaseLightAccent.opacity(0.35) : Color.clear, radius: 8, x: 0, y: 2)
    }
    static func shadowsChaseLightSecondaryButton() -> some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(Color(red: 0.2, green: 0.35, blue: 0.5).opacity(0.2))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(shadowsChaseLightGlassStroke, lineWidth: 1)
            )
    }
    static var shadowsChaseLightTitleFont: Font {
        .system(size: 24, weight: .semibold, design: .rounded)
    }
    static var shadowsChaseLightHeadlineFont: Font {
        .system(size: 20, weight: .semibold, design: .rounded)
    }
    static var shadowsChaseLightBodyFont: Font {
        .system(size: 17, weight: .regular, design: .rounded)
    }
    static var shadowsChaseLightCaptionFont: Font {
        .system(size: 15, weight: .medium, design: .rounded)
    }
    static var shadowsChaseLightSmallFont: Font {
        .system(size: 13, weight: .regular, design: .rounded)
    }
}

struct ShadowsChaseLightProgressBarStyle: View {
    let progress: Double
    let height: CGFloat

    init(progress: Double, height: CGFloat = 10) {
        self.progress = progress
        self.height = height
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(Color(red: 0.2, green: 0.35, blue: 0.5).opacity(0.3))
                    .frame(height: height)
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(
                        LinearGradient(
                            colors: [ShadowsChaseLightDesign.shadowsChaseLightAccent, ShadowsChaseLightDesign.shadowsChaseLightAccent.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(0, geo.size.width * progress), height: height)
            }
        }
        .frame(height: height)
    }
}

struct ShadowsChaseLightScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
