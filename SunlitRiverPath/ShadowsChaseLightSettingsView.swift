import SwiftUI

struct ShadowsChaseLightSettingsView: View {
    @StateObject private var shadowsChaseLightSettingsVM = ShadowsChaseLightSettingsViewModel()
    @State private var shadowsChaseLightShowResetAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Difficulty")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Light Chase Precision")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            Slider(value: $shadowsChaseLightSettingsVM.shadowsChaseLightLightChasePrecisionValue, in: 0...1)
                                .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                .onChange(of: shadowsChaseLightSettingsVM.shadowsChaseLightLightChasePrecisionValue) { _ in
                                    shadowsChaseLightSettingsVM.shadowsChaseLightPersist()
                                }
                        }
                        .padding(18)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Graffiti Cipher Complexity")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            Slider(value: $shadowsChaseLightSettingsVM.shadowsChaseLightGraffitiCipherComplexityValue, in: 0...1)
                                .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                .onChange(of: shadowsChaseLightSettingsVM.shadowsChaseLightGraffitiCipherComplexityValue) { _ in
                                    shadowsChaseLightSettingsVM.shadowsChaseLightPersist()
                                }
                        }
                        .padding(18)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Traffic Pulse Speed")
                                .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                            Slider(value: $shadowsChaseLightSettingsVM.shadowsChaseLightTrafficPulseSpeedValue, in: 0...1)
                                .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                .onChange(of: shadowsChaseLightSettingsVM.shadowsChaseLightTrafficPulseSpeedValue) { _ in
                                    shadowsChaseLightSettingsVM.shadowsChaseLightPersist()
                                }
                        }
                        .padding(18)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))

                        Text("Appearance")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        Picker("Interface style", selection: $shadowsChaseLightSettingsVM.shadowsChaseLightInterfaceStyleValue) {
                            ForEach(ShadowsChaseLightInterfaceStyle.allCases, id: \.self) { style in
                                Text(style.rawValue).tag(style)
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: shadowsChaseLightSettingsVM.shadowsChaseLightInterfaceStyleValue) { _ in
                            shadowsChaseLightSettingsVM.shadowsChaseLightPersist()
                        }

                        Text("Sound")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        Picker("Sound mode", selection: $shadowsChaseLightSettingsVM.shadowsChaseLightSoundModeValue) {
                            Text("City Noise").tag(ShadowsChaseLightSoundMode.cityNoise)
                            Text("Calm Waves").tag(ShadowsChaseLightSoundMode.calmWaves)
                            Text("Silent Streets").tag(ShadowsChaseLightSoundMode.silentStreets)
                        }
                        .pickerStyle(.menu)
                        .onChange(of: shadowsChaseLightSettingsVM.shadowsChaseLightSoundModeValue) { newVal in
                            shadowsChaseLightSettingsVM.shadowsChaseLightSilentStreetsEnabled = (newVal == .silentStreets)
                            shadowsChaseLightSettingsVM.shadowsChaseLightPersist()
                        }

                        Toggle("Silent Streets (no sounds)", isOn: $shadowsChaseLightSettingsVM.shadowsChaseLightSilentStreetsEnabled)
                            .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                            .onChange(of: shadowsChaseLightSettingsVM.shadowsChaseLightSilentStreetsEnabled) { _ in
                                shadowsChaseLightSettingsVM.shadowsChaseLightPersist()
                            }

                        Text("Statistics")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightHeadlineFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
                        VStack(alignment: .leading, spacing: 10) {
                            statRow("Match pair games", value: "\(shadowsChaseLightSettingsVM.shadowsChaseLightMatchPairGamesWon)")
                            statRow("Best moves", value: shadowsChaseLightSettingsVM.shadowsChaseLightMatchPairBestMoves == 999 ? "—" : "\(shadowsChaseLightSettingsVM.shadowsChaseLightMatchPairBestMoves)")
                            statRow("Lore unlocked", value: "\(shadowsChaseLightSettingsVM.shadowsChaseLightLoreUnlockedCount)")
                        }
                        .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                        .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                        .padding(18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))

                        Button("Reset all data") {
                            shadowsChaseLightShowResetAlert = true
                        }
                        .font(ShadowsChaseLightDesign.shadowsChaseLightCaptionFont)
                        .foregroundColor(.red)
                        .padding(.top, 4)

                        Link(destination: URL(string: "https://sunlitriverpath.com/privacy-policy.html")!) {
                            HStack {
                                Text("Privacy Policy")
                                    .font(ShadowsChaseLightDesign.shadowsChaseLightBodyFont)
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                            }
                            .padding(16)
                            .background(ShadowsChaseLightDesign.shadowsChaseLightCardBackground(cornerRadius: 16))
                        }
                        .padding(.top, 8)

                        Text("No accounts or login. All data stored locally. Silent Streets disables sounds and notifications.")
                            .font(ShadowsChaseLightDesign.shadowsChaseLightSmallFont)
                            .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightTextTertiary)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("⚙️ Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient, for: .navigationBar)
            .onAppear {
                shadowsChaseLightSettingsVM.shadowsChaseLightRefreshStats()
            }
            .alert("Reset all data?", isPresented: $shadowsChaseLightShowResetAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    shadowsChaseLightSettingsVM.shadowsChaseLightResetAllData()
                }
            } message: {
                Text("This will clear all progress, spirit state, lore, and shop.")
            }
        }
    }

    private func statRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(ShadowsChaseLightDesign.shadowsChaseLightAccent)
        }
    }
}
