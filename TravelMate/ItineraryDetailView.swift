
import SwiftUI

struct ItineraryDetailView: View {
    let itinerary: Itinerary

    var body: some View {
        Form {
            Section(header: Text("Destination")) {
                Text(itinerary.destination)
            }

            Section(header: Text("Dates")) {
                Text("Start: \(formattedDate(itinerary.startDate))")
                Text("End: \(formattedDate(itinerary.endDate))")
            }

            Section(header: Text("Activity")) {
                Text(itinerary.activity)
            }
        }
        .navigationTitle("Itinerary Details")
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
