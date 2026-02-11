import Foundation

/// يمثل أوقات الصلوات اليومية.
struct PrayerTimes: Codable {
    let fajr: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String
}

/// يمثل آية من القرآن الكريم.
struct Ayah: Codable, Identifiable {
    let id: Int
    let surahName: String
    let numberInSurah: Int
    let text: String
}

/// يمثل حديثًا نبويًا.
struct Hadith: Codable, Identifiable {
    let id: Int
    let source: String
    let text: String
}

/// يمثل سورة كاملة أو جزءًا منها.
struct Surah: Codable, Identifiable {
    let id: Int
    let name: String
    let verses: [Ayah]
    let audioURL: URL?
}

/// يمثل ذكرًا من أذكار الصباح أو المساء.
struct DhikrItem: Codable, Identifiable {
    let id: Int
    let title: String
    let text: String
    let repeatCount: Int
}
