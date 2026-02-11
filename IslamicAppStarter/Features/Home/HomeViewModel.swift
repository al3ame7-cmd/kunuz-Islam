import Foundation

/// ViewModel لشاشة الرئيسية وفق MVVM.
@MainActor
final class HomeViewModel: ObservableObject {
    @Published var prayerTimes: PrayerTimes?
    @Published var dailyAyah: Ayah?
    @Published var dailyHadith: Hadith?
    @Published var errorMessage: String?

    private let prayerService: PrayerServiceProtocol
    private let dailyContentService: DailyContentServiceProtocol

    init(
        prayerService: PrayerServiceProtocol = PrayerService(),
        dailyContentService: DailyContentServiceProtocol = DailyContentService()
    ) {
        self.prayerService = prayerService
        self.dailyContentService = dailyContentService
    }

    /// تحميل بيانات الشاشة الرئيسية مرة واحدة.
    func loadHomeData(latitude: Double, longitude: Double) async {
        do {
            async let prayerTask = prayerService.fetchPrayerTimes(latitude: latitude, longitude: longitude)
            async let ayahTask = dailyContentService.fetchDailyAyah()
            async let hadithTask = dailyContentService.fetchDailyHadith()

            prayerTimes = try await prayerTask
            dailyAyah = try await ayahTask
            dailyHadith = try await hadithTask
        } catch {
            errorMessage = "تعذر تحميل البيانات. حاول مرة أخرى."
        }
    }
}
