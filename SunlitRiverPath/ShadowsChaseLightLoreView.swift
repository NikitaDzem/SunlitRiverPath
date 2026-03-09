import SwiftUI

struct ShadowsChaseLightLoreView: View {
    @StateObject private var shadowsChaseLightLoreVM = ShadowsChaseLightLoreViewModel()

    private var shadowsChaseLightFacts: [ShadowsChaseLightFactEntry] {
        ShadowsChaseLightLoreViewModel.shadowsChaseLightFactsList()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(shadowsChaseLightFacts) { fact in
                            NavigationLink(value: fact) {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Image(systemName: "text.book.closed.fill")
                                            .font(.system(size: 18))
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                        Text(fact.shadowsChaseLightFactTitle)
                                            .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(fact.shadowsChaseLightFactPreview)
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    HStack(spacing: 6) {
                                        Text("Read more")
                                            .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                    }
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                                .padding(.horizontal, 16)
                            }
                            .buttonStyle(ShadowsChaseLightScaleButtonStyle())
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("📖 Facts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient, for: .navigationBar)
            .navigationDestination(for: ShadowsChaseLightFactEntry.self) { fact in
                ShadowsChaseLightFactDetailView(shadowsChaseLightFact: fact)
            }
        }
    }
}

extension ShadowsChaseLightFactEntry: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: ShadowsChaseLightFactEntry, rhs: ShadowsChaseLightFactEntry) -> Bool {
        lhs.id == rhs.id
    }
}
