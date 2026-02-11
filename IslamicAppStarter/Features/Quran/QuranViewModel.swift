import Foundation
import AVFoundation

/// ViewModel لقسم القرآن الكريم.
@MainActor
final class QuranViewModel: ObservableObject {
    @Published var surahs: [Surah] = []
    @Published var filteredSurahs: [Surah] = []
    @Published var searchText: String = "" {
        didSet { applySearch() }
    }

    private let quranService: QuranServiceProtocol
    private var player: AVPlayer?

    init(quranService: QuranServiceProtocol = QuranService()) {
        self.quranService = quranService
    }

    /// تحميل السور المعروضة في الشاشة.
    func loadSurahs() async {
        do {
            surahs = try await quranService.fetchSurahs()
            filteredSurahs = surahs
        } catch {
            filteredSurahs = []
        }
    }

    /// تطبيق البحث على السور والآيات.
    private func applySearch() {
        guard !searchText.isEmpty else {
            filteredSurahs = surahs
            return
        }

        filteredSurahs = quranService.search(query: searchText, within: surahs)
    }

    /// تشغيل التلاوة الصوتية لسورة مختارة.
    func playRecitation(for surah: Surah) {
        guard let audioURL = surah.audioURL else { return }
        player = AVPlayer(url: audioURL)
        player?.play()
    }
}
