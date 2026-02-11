import SwiftUI
import CoreLocation

/// واجهة اتجاه القبلة مع مؤشر زاوية.
struct QiblaView: View {
    @StateObject var viewModel: QiblaViewModel
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "location.north.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(viewModel.qiblaAngle))
                    .foregroundStyle(.green)

                Text("زاوية القبلة: \(Int(viewModel.qiblaAngle))°")
                    .font(.title3)

                Button("تحديث الاتجاه") {
                    locationManager.requestLocation()
                    if let coordinate = locationManager.location?.coordinate {
                        viewModel.updateQiblaDirection(userCoordinate: coordinate)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("اتجاه القبلة")
        }
    }
}
