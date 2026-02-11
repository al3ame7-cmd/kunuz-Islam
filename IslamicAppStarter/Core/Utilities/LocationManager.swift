import Foundation
import CoreLocation

/// مدير الموقع للحصول على إحداثيات المستخدم لمواقيت الصلاة والقبلة.
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    /// أحدث موقع معروف.
    @Published var location: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    /// يطلب صلاحية الموقع ويبدأ التحديث.
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
}
