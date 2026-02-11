import Foundation

/// بروتوكول خدمة القرآن (السور، البحث، التلاوة).
protocol QuranServiceProtocol {
    func fetchSurahs() async throws -> [Surah]
    func search(query: String, within surahs: [Surah]) -> [Surah]
}

/// خدمة القرآن باستخدام API مثل AlQuran Cloud.
final class QuranService: QuranServiceProtocol {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }

    func fetchSurahs() async throws -> [Surah] {
        /// هذا مجرد Stub أولي. في التطبيق الحقيقي يتم تحويل الاستجابة الكاملة من API.
        guard let sampleAudio = URL(string: "https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3") else {
            return []
        }

        return [
            Surah(
                id: 1,
                name: "الفاتحة",
                verses: [
                    Ayah(id: 1, surahName: "الفاتحة", numberInSurah: 1, text: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ")
                ],
                audioURL: sampleAudio
            )
        ]
    }

    func search(query: String, within surahs: [Surah]) -> [Surah] {
        /// بحث بسيط بالاسم أو داخل نص الآيات.
        surahs.filter { surah in
            surah.name.contains(query) || surah.verses.contains { $0.text.contains(query) }
        }
    }
}
