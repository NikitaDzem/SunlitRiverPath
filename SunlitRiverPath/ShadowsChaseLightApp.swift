import SwiftUI

@main
struct ShadowsChaseLightApp: App {
    @UIApplicationDelegateAdaptor(ShadowsChaseLightAppDelegate.self) private var appDelegate
    @State private var isLoading = true
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    ShadowsChaseLightLoadingView()
                        .onAppear {
                            ShadowsChaseLightAppDelegate.orientationShadowsChaseLight = .all
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isLoading = false
                                }
                            }
                        }
                        .ignoresSafeArea()
                } else if !hasCompletedOnboarding {
                    ShadowsChaseLightOnboardingView(
                        hasCompletedOnboarding: $hasCompletedOnboarding
                    )
                    .onAppear {
                        ShadowsChaseLightAppDelegate.orientationShadowsChaseLight = .portrait
                    }
                    .ignoresSafeArea()
                } else {
                    ShadowsChaseLightTabView()
                        .onAppear {
                            ShadowsChaseLightAppDelegate.orientationShadowsChaseLight = .portrait
                        }
                }
            }
        }
    }
}
