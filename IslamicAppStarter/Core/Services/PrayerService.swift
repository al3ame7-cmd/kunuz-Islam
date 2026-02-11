import Foundation
import CoreLocation

/// بروتوكول خدمة مواقيت الصلاة ليسهل الاختبار والاستبدال.
protocol PrayerServiceProtocol {
    func fetchPrayerTimes(latitude: Double, longitude: Double) async throws -> PrayerTimes
}

/// خدمة مواقيت الصلاة باستخدام API موثوق مثل AlAdhan.
final class PrayerService: PrayerServiceProtocol {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }

    func fetchPrayerTimes(latitude: Double, longitude: Double) async throws -> PrayerTimes {
        /// يمكن تغيير الرابط والـ method حسب توثيق API الحقيقي.
        guard let url = URL(string: "https://api.aladhan.com/v1/timings?latitude=\(latitude)&longitude=\(longitude)&method=4") else {
            throw APIError.invalidURL
        }

        /// نموذج استجابة مبسط لتوضيح الفكرة.
        struct Response: Decodable {
            struct DataNode: Decodable {
                struct TimingsNode: Decodable {
                    let Fajr: String
                    let Dhuhr: String
                    let Asr: String
                    let Maghrib: String
                    let Isha: String
                }
                let timings: TimingsNode
            }
            let data: DataNode
        }

        let response = try await httpClient.get(url, as: Response.self)
        return PrayerTimes(
            fajr: response.data.timings.Fajr,
            dhuhr: response.data.timings.Dhuhr,
            asr: response.data.timings.Asr,
            maghrib: response.data.timings.Maghrib,
            isha: response.data.timings.Isha
        )
    }
}
