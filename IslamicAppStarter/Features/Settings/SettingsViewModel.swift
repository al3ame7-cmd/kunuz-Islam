import Foundation

/// ViewModel للإعدادات العامة مثل الوضع الليلي.
@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool = false

    /// تبديل الوضع الليلي/النهاري.
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
}
