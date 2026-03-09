import SwiftUI

struct ShadowsChaseLightShopOverlayView: View {
    let shadowsChaseLightMessage: ShadowsChaseLightShopOverlayMessage
    let shadowsChaseLightOnDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    shadowsChaseLightOnDismiss()
                }
            VStack(spacing: 20) {
                switch shadowsChaseLightMessage {
                case .purchaseSuccess(let item):
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [ShadowsChaseLightDesign.shadowsChaseLightAccent, ShadowsChaseLightDesign.shadowsChaseLightAccent.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    Text("Purchased!")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                    Text(item.shadowsChaseLightShopTitle)
                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                    Text("+\(item.shadowsChaseLightShopIncomePerMinute) coins/min")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                case .notEnoughCoins(let needed):
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 56))
                        .foregroundColor(.orange)
                    Text("Not enough coins")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                    Text("You need \(needed) coins")
                        .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                }
                Button("OK") {
                    shadowsChaseLightOnDismiss()
                }
                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                .clipShape(Capsule())
                .padding(.top, 8)
            }
            .padding(32)
            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 24))
            .padding(40)
        }
    }
}
