import SwiftUI

struct ItineraryListView: View {
    @ObservedObject var itineraryViewModel: ItineraryViewModel

    var body: some View {
        List {
            ForEach(itineraryViewModel.itineraries) { itinerary in
                NavigationLink(destination: ItineraryDetailView(itinerary: itinerary)) {
                    VStack(alignment: .leading) {
                        Text(itinerary.destination)
                            .font(.headline)
                        Text("\(formattedDate(itinerary.startDate)) → \(formattedDate(itinerary.endDate))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
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

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

