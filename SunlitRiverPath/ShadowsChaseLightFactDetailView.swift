import SwiftUI

struct ShadowsChaseLightFactDetailView: View {
    let shadowsChaseLightFact: ShadowsChaseLightFactEntry
    @Environment(\.dismiss) private var shadowsChaseLightDismiss

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(shadowsChaseLightFact.shadowsChaseLightFactTitle)
                        .font(.system(size: 26, weight: .semibold, design: .rounded))
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        .lineSpacing(4)
                        .padding(.top, 8)
                    Text(shadowsChaseLightFact.shadowsChaseLightFactPreview)
                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                        .lineSpacing(2)
                    Rectangle()
                        .fill(ShadowsChaseLightDesign.shadowsChaseLightAccent.opacity(0.5))
                        .frame(height: 2)
                    Text(shadowsChaseLightFact.shadowsChaseLightFactFullDetail)
                        .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        .lineSpacing(8)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        shadowsChaseLightDismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
        }
        .onAppear {
            let store = ShadowsChaseLightStorage()
            let key = ShadowsChaseLightStorageKeys.shadowsChaseLightFactsReadIds
            var ids: [String] = []
            if let data = store.shadowsChaseLightReadData(key: key), let decoded = try? JSONDecoder().decode([String].self, from: data) {
                ids = decoded
            }
            if !ids.contains(shadowsChaseLightFact.id) {
                ids.append(shadowsChaseLightFact.id)
                if let data = try? JSONEncoder().encode(ids) {
                    store.shadowsChaseLightWriteData(key: key, value: data)
                }
            }
        }
    }
}
