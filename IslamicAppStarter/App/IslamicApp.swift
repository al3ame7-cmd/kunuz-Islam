import SwiftUI

/// نقطة دخول التطبيق. تربط البيئة العامة بالواجهة الأساسية.
@main
struct IslamicApp: App {
    /// كائن إعدادات عام لمشاركة الثيم والوضع الليلي بين الشاشات.
    @StateObject private var settingsViewModel = SettingsViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(settingsViewModel)
                .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
        }
    }
}
