import SwiftUI

/// واجهة الشاشة الرئيسية: مواقيت الصلاة + آية + حديث.
struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    prayerTimesCard
                    dailyAyahCard
                    dailyHadithCard
                }
                .padding()
            }
            .navigationTitle("الرئيسية")
            .task {
                /// طلب الموقع ثم تحميل البيانات.
                locationManager.requestLocation()
                if let location = locationManager.location {
                    await viewModel.loadHomeData(
                        latitude: location.coordinate.latitude,
                        longitude: location.coordinate.longitude
                    )
                }
            }
        }
    }

    /// بطاقة مواقيت الصلاة.
    private var prayerTimesCard: some View {
        GroupBox("مواقيت الصلاة") {
            if let times = viewModel.prayerTimes {
                VStack(alignment: .leading, spacing: 8) {
                    Text("الفجر: \(times.fajr)")
                    Text("الظهر: \(times.dhuhr)")
                    Text("العصر: \(times.asr)")
                    Text("المغرب: \(times.maghrib)")
                    Text("العشاء: \(times.isha)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                ProgressView("جاري تحميل المواقيت...")
            }
        }
    }

    /// بطاقة آية اليوم.
    private var dailyAyahCard: some View {
        GroupBox("آية اليوم") {
            Text(viewModel.dailyAyah?.text ?? "جاري تحميل الآية...")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    /// بطاقة حديث اليوم.
    private var dailyHadithCard: some View {
        GroupBox("حديث اليوم") {
            Text(viewModel.dailyHadith?.text ?? "جاري تحميل الحديث...")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
