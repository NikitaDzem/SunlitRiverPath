//
//  ShadowsChaseLightOnboardingView.swift
//  SunlitRiverPath
//

import SwiftUI

struct ShadowsChaseLightOnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)

                Text("Discover the world of Shadows Chase Light")
                    .font(.body)
                    .foregroundStyle(ShadowsChaseLightDesign.shadowsChaseLightTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        hasCompletedOnboarding = true
                    }
                } label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .background(ShadowsChaseLightDesign.shadowsChaseLightPrimaryButton(enabled: true))
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ShadowsChaseLightOnboardingView(hasCompletedOnboarding: .constant(false))
}
