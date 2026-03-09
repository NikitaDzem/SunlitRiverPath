import SwiftUI

struct ShadowsChaseLightTabView: View {
    @State private var shadowsChaseLightSelectedTab = 0

    var body: some View {
        TabView(selection: $shadowsChaseLightSelectedTab) {
            ShadowsChaseLightSpiritView()
                .tabItem {
                    Label("🌊 Spirit", systemImage: "building.2.fill")
                }
                .tag(0)
            ShadowsChaseLightMiniGamesView()
                .tabItem {
                    Label("🎮 Games", systemImage: "gamecontroller.fill")
                }
                .tag(1)
            ShadowsChaseLightLoreView()
                .tabItem {
                    Label("📖 Lore", systemImage: "book.fill")
                }
                .tag(2)
            ShadowsChaseLightShopView()
                .tabItem {
                    Label("🛒 Shop", systemImage: "cart.fill")
                }
                .tag(3)
            ShadowsChaseLightSettingsView()
                .tabItem {
                    Label("⚙️ Settings", systemImage: "gearshape.fill")
                }
                .tag(4)
        }
        .tint(ShadowsChaseLightDesign.shadowsChaseLightAccent)
        .preferredColorScheme(.dark)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(red: 0.06, green: 0.1, blue: 0.2, alpha: 0.98)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
