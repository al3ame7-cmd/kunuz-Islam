import SwiftUI

/// واجهة قسم القرآن: عرض، بحث، وتشغيل تلاوة.
struct QuranView: View {
    @StateObject var viewModel: QuranViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.filteredSurahs) { surah in
                Section(surah.name) {
                    ForEach(surah.verses) { ayah in
                        Text("\(ayah.numberInSurah). \(ayah.text)")
                    }

                    Button("تشغيل التلاوة") {
                        viewModel.playRecitation(for: surah)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "ابحث عن سورة أو آية")
            .navigationTitle("القرآن الكريم")
            .task {
                await viewModel.loadSurahs()
            }
        }
    }
}
