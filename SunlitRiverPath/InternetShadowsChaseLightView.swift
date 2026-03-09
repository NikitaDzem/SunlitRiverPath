//
//  InternetShadowsChaseLightView.swift
//  SunlitRiverPath
//

import SwiftUI

struct InternetShadowsChaseLightView: View {
    @State private var opacityShadowsChaseLight = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("mainbgShadowsChaseLight")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .ignoresSafeArea()

                VStack {
                    Image("alertShadowsChaseLight")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipped()
                        .cornerRadius(20)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .opacity(opacityShadowsChaseLight)
            .animation(.linear(duration: 0.325), value: opacityShadowsChaseLight)
            .onAppear {
                opacityShadowsChaseLight = 1
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    InternetShadowsChaseLightView()
}
