import Foundation
import CoreLocation

/// حاسبة اتجاه القبلة من موقع المستخدم إلى الكعبة المشرفة.
struct QiblaCalculator {
    /// إحداثيات الكعبة.
    private let kaaba = CLLocationCoordinate2D(latitude: 21.4225, longitude: 39.8262)

    /// يعيد الزاوية المطلوبة (بالدرجات) نسبة إلى الشمال.
    func bearing(from userCoordinate: CLLocationCoordinate2D) -> Double {
        let userLat = userCoordinate.latitude.radians
        let userLon = userCoordinate.longitude.radians
        let kaabaLat = kaaba.latitude.radians
        let kaabaLon = kaaba.longitude.radians

        let deltaLon = kaabaLon - userLon
        let y = sin(deltaLon) * cos(kaabaLat)
        let x = cos(userLat) * sin(kaabaLat) - sin(userLat) * cos(kaabaLat) * cos(deltaLon)

        let angle = atan2(y, x).degrees
        return (angle + 360).truncatingRemainder(dividingBy: 360)
    }
}

private extension Double {
    var radians: Double { self * .pi / 180 }
    var degrees: Double { self * 180 / .pi }
}
