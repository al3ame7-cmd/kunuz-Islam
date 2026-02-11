import Foundation

/// ViewModel لقسم الأذكار والسبحة الإلكترونية.
@MainActor
final class AzkarViewModel: ObservableObject {
    @Published var morningAzkar: [DhikrItem] = []
    @Published var eveningAzkar: [DhikrItem] = []
    @Published var tasbihCount: Int = 0

    init() {
        loadAzkar()
    }

    /// تحميل بيانات أذكار مبدئية (يمكن استبدالها بملف JSON محلي أو API).
    private func loadAzkar() {
        morningAzkar = [
            DhikrItem(id: 1, title: "ذكر الصباح", text: "أصبحنا وأصبح الملك لله...", repeatCount: 1)
        ]

        eveningAzkar = [
            DhikrItem(id: 2, title: "ذكر المساء", text: "أمسينا وأمسى الملك لله...", repeatCount: 1)
        ]
    }

    /// زيادة عداد التسبيح بمقدار واحد.
    func incrementTasbih() {
        tasbihCount += 1
    }

    /// إعادة تصفير العداد.
    func resetTasbih() {
        tasbihCount = 0
    }
}
