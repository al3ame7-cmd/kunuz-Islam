import SwiftUI

/// الحاوية الأساسية للتنقل بين أقسام التطبيق.
struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label("الرئيسية", systemImage: "house")
                }

            QuranView(viewModel: QuranViewModel())
                .tabItem {
                    Label("القرآن", systemImage: "book")
                }

            AzkarView(viewModel: AzkarViewModel())
                .tabItem {
                    Label("الأذكار", systemImage: "hands.sparkles")
                }

            QiblaView(viewModel: QiblaViewModel())
                .tabItem {
                    Label("القبلة", systemImage: "location.north.line")
                }
        }
    }
}
