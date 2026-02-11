import SwiftUI

/// واجهة الأذكار (صباح/مساء) + سبحة إلكترونية.
struct AzkarView: View {
    @StateObject var viewModel: AzkarViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    azkarSection(title: "أذكار الصباح", items: viewModel.morningAzkar)
                    azkarSection(title: "أذكار المساء", items: viewModel.eveningAzkar)
                    tasbihSection
                }
                .padding()
            }
            .navigationTitle("الأذكار")
        }
    }

    /// قسم عام لعرض قائمة أذكار.
    private func azkarSection(title: String, items: [DhikrItem]) -> some View {
        GroupBox(title) {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(items) { item in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.text)
                        Text("عدد التكرار: \(item.repeatCount)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    /// واجهة عداد التسبيح.
    private var tasbihSection: some View {
        GroupBox("السبحة الإلكترونية") {
            VStack(spacing: 10) {
                Text("العدد الحالي: \(viewModel.tasbihCount)")
                    .font(.headline)

                HStack {
                    Button("تسبيح +1") {
                        viewModel.incrementTasbih()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("إعادة ضبط") {
                        viewModel.resetTasbih()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
