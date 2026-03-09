import SwiftUI

struct ShadowsChaseLightAchievementsView: View {
    @StateObject private var shadowsChaseLightAchievementsVM = ShadowsChaseLightAchievementsViewModel()
    var shadowsChaseLightOnDismiss: (() -> Void)? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Complete tasks to earn achievements. Progress is saved automatically.")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)

                        ForEach(shadowsChaseLightAchievementsVM.shadowsChaseLightAchievements) { item in
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text(item.shadowsChaseLightTitle)
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                                    Spacer()
                                    if item.shadowsChaseLightEarned {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                    }
                                }
                                Text(item.shadowsChaseLightDescription)
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                                HStack {
                                    Text("\(item.shadowsChaseLightCurrent)/\(item.shadowsChaseLightTarget)")
                                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                    Spacer()
                                }
                                ShadowsChaseLightProgressBarStyle(progress: item.shadowsChaseLightProgress, height: 10)
                                Text("\"\(item.shadowsChaseLightMentorQuote)\"")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                                    .italic()
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                            }
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .navigationTitle("🏆 Achievements")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient, for: .navigationBar)
            .toolbar {
                if shadowsChaseLightOnDismiss != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") { shadowsChaseLightOnDismiss?() }
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                    }
                }
            }
            .onAppear {
                shadowsChaseLightAchievementsVM.shadowsChaseLightRefresh()
            }
        }
    }
}
