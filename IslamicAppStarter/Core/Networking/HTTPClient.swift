import Foundation

/// عميل HTTP بسيط لتوحيد عمليات الشبكة في التطبيق.
protocol HTTPClient {
    func get<T: Decodable>(_ url: URL, as type: T.Type) async throws -> T
}

/// تنفيذ فعلي باستخدام URLSession.
final class URLSessionHTTPClient: HTTPClient {
    func get<T>(_ url: URL, as type: T.Type) async throws -> T where T : Decodable {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
