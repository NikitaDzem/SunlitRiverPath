import SwiftUI

struct ShadowsChaseLightShopView: View {
    @StateObject private var shadowsChaseLightShopVM = ShadowsChaseLightShopViewModel()

    private var shadowsChaseLightItems: [ShadowsChaseLightShopItem] {
        ShadowsChaseLightShopViewModel.shadowsChaseLightShopItemsList()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        HStack(alignment: .top, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("💰 Balance")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    Image(systemName: "dollarsign.circle.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                    Text("\(shadowsChaseLightShopVM.shadowsChaseLightBalance)")
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                }
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 8) {
                                Text("⏱️ Passive income")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                HStack(spacing: 6) {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .font(.system(size: 18))
                                    Text("+\(shadowsChaseLightShopVM.shadowsChaseLightTotalIncomePerMinute)/min")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                }
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            }
                        }
                        .padding(20)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        .padding(.horizontal, 16)

                        Text("Play mini-games to earn coins, then buy upgrades for passive income.")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)

                        ForEach(shadowsChaseLightItems) { item in
                            Button {
                                shadowsChaseLightShopVM.shadowsChaseLightSelectedItem = item
                            } label: {
                                HStack(alignment: .top, spacing: 16) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(item.shadowsChaseLightShopTitle)
                                            .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(item.shadowsChaseLightShopDescription)
                                            .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                            .lineLimit(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        HStack(spacing: 16) {
                                            HStack(spacing: 4) {
                                                Image(systemName: "dollarsign")
                                                    .font(.system(size: 14, weight: .semibold))
                                                Text("\(item.shadowsChaseLightShopCost)")
                                                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                            }
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                            HStack(spacing: 4) {
                                                Image(systemName: "clock.arrow.circlepath")
                                                    .font(.system(size: 12))
                                                Text(item.id == "shop_building_kit" ? "Material for Spirit" : "+\(item.shadowsChaseLightShopIncomePerMinute)/min")
                                                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                            }
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                        }
                                        let owned = shadowsChaseLightShopVM.shadowsChaseLightOwnedCount(for: item.id)
                                        if owned > 0 {
                                            Text("Owned: \(owned)")
                                                .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                                        }
                                    }
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                                .padding(.horizontal, 16)
                            }
                            .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        }

                        Button {
                            shadowsChaseLightShopVM.shadowsChaseLightAddTestCoins()
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "plus.circle.fill")
                                Text("Add 500 coins (test)")
                            }
                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        }
                        .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        .padding(.top, 4)
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("🛒 Shop")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient, for: .navigationBar)
            .onAppear {
                shadowsChaseLightShopVM.shadowsChaseLightRefreshBalance()
            }
            .sheet(item: $shadowsChaseLightShopVM.shadowsChaseLightSelectedItem) { item in
                ShadowsChaseLightShopPurchaseSheet(
                    shadowsChaseLightItem: item,
                    shadowsChaseLightBalance: shadowsChaseLightShopVM.shadowsChaseLightBalance,
                    shadowsChaseLightOnPurchase: {
                        shadowsChaseLightShopVM.shadowsChaseLightPurchase(item: item)
                    },
                    shadowsChaseLightOnDismiss: {
                        shadowsChaseLightShopVM.shadowsChaseLightClosePurchaseSheet()
                    }
                )
            }
            .overlay {
                if let message = shadowsChaseLightShopVM.shadowsChaseLightOverlayMessage {
                    ShadowsChaseLightShopOverlayView(
                        shadowsChaseLightMessage: message,
                        shadowsChaseLightOnDismiss: {
                            shadowsChaseLightShopVM.shadowsChaseLightCloseOverlay()
                        }
                    )
                }
            }
        }
    }
}

struct ShadowsChaseLightShopPurchaseSheet: View {
    let shadowsChaseLightItem: ShadowsChaseLightShopItem
    let shadowsChaseLightBalance: Int
    let shadowsChaseLightOnPurchase: () -> Void
    let shadowsChaseLightOnDismiss: () -> Void

    private var shadowsChaseLightCanAfford: Bool {
        shadowsChaseLightBalance >= shadowsChaseLightItem.shadowsChaseLightShopCost
    }

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Text(shadowsChaseLightItem.shadowsChaseLightShopTitle)
                    .font(ShadowsChaseLightDesign.shadowsChaseLightTitleFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                Text(shadowsChaseLightItem.shadowsChaseLightShopDescription)
                    .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                VStack(spacing: 12) {
                    HStack {
                        Text("Cost")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        Spacer()
                        Text("\(shadowsChaseLightItem.shadowsChaseLightShopCost) coins")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                    }
                    HStack {
                        Text("Income")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        Spacer()
                        Text(shadowsChaseLightItem.id == "shop_building_kit" ? "Use on Spirit to build house (+1/min)" : "+\(shadowsChaseLightItem.shadowsChaseLightShopIncomePerMinute) per minute")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                    }
                    HStack {
                        Text("Your balance")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        Spacer()
                        Text("\(shadowsChaseLightBalance) coins")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                            .foregroundColor(shadowsChaseLightCanAfford ? ShadowsChaseLightDesign.shadowsChaseLightTextPrimary : .orange)
                    }
                }
                .padding(20)
                .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                .padding(.horizontal, 24)

                HStack(spacing: 16) {
                    Button("Cancel") {
                        shadowsChaseLightOnDismiss()
                    }
                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(ShadowsChaseLightDesign.shadowsChaseLightSecondaryButton())

                    Button("Buy") {
                        shadowsChaseLightOnPurchase()
                    }
                    .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(ShadowsChaseLightDesign.shadowsChaseLightPrimaryButton(enabled: shadowsChaseLightCanAfford))
                    .disabled(!shadowsChaseLightCanAfford)
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 32)
        }
        .presentationDetents([.medium, .large])
    }
}

extension ShadowsChaseLightShopItem: Hashable {
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: ShadowsChaseLightShopItem, rhs: ShadowsChaseLightShopItem) -> Bool { lhs.id == rhs.id }
}
