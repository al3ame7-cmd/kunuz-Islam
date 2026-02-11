import Foundation
import CoreLocation

/// ViewModel لقسم اتجاه القبلة.
@MainActor
final class QiblaViewModel: ObservableObject {
    @Published var qiblaAngle: Double = 0

    private let calculator = QiblaCalculator()

    /// تحديث الزاوية اعتمادًا على موقع المستخدم الحالي.
    func updateQiblaDirection(userCoordinate: CLLocationCoordinate2D) {
        qiblaAngle = calculator.bearing(from: userCoordinate)
    }
}
