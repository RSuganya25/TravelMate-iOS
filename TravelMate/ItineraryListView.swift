import SwiftUI

struct ItineraryListView: View {
    @ObservedObject var itineraryViewModel: ItineraryViewModel

    var body: some View {
        List {
            ForEach(itineraryViewModel.itineraries) { itinerary in
                Text(itinerary.destination)
            }
            .onDelete(perform: deleteItinerary)
        }
        .navigationTitle("Itineraries")
        .toolbar {
            EditButton()
        }
    }

    func deleteItinerary(at offsets: IndexSet) {
        itineraryViewModel.itineraries.remove(atOffsets: offsets)
    }
}

