//
//  ShadowsChaseLightLoadingView.swift
//  SunlitRiverPath
//

import SwiftUI

struct ShadowsChaseLightLoadingView: View {
    var body: some View {
        ZStack {
            ShadowsChaseLightDesign.shadowsChaseLightBackgroundGradient
                .ignoresSafeArea()

            VStack(spacing: 24) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
                    .scaleEffect(1.4)

                Text("Loading...")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(ShadowsChaseLightDesign.shadowsChaseLightTextPrimary)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ShadowsChaseLightLoadingView()
}
