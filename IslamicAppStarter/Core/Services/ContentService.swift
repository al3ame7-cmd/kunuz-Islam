import Foundation

/// بروتوكول يجلب الآية والحديث اليومي.
protocol DailyContentServiceProtocol {
    func fetchDailyAyah() async throws -> Ayah
    func fetchDailyHadith() async throws -> Hadith
}

/// تنفيذ أولي لعرض فكرة شاشة المحتوى اليومي.
final class DailyContentService: DailyContentServiceProtocol {
    func fetchDailyAyah() async throws -> Ayah {
        Ayah(
            id: 255,
            surahName: "البقرة",
            numberInSurah: 255,
            text: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ..."
        )
    }

    func fetchDailyHadith() async throws -> Hadith {
        Hadith(
            id: 1,
            source: "صحيح البخاري",
            text: "إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ..."
        )
    }
}
