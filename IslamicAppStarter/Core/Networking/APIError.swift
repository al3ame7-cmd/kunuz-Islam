import Foundation

/// أخطاء الشبكة المتوقعة أثناء طلب البيانات.
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
}
