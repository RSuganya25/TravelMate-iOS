import SwiftUI

struct ContentView: View {
    @ObservedObject var itineraryViewModel: ItineraryViewModel

    var defaultDestination: String
    var defaultActivity: String

    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var activity = ""
    @State private var showSummary = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Destination", text: $destination)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    TextField("Activity Preferences", text: $activity)
                }

                Button("Create Itinerary") {
                    let newItinerary = Itinerary(destination: destination, startDate: startDate, endDate: endDate, activity: activity)
                    itineraryViewModel.itineraries.append(newItinerary)
                    showSummary = true
                }
                .disabled(destination.isEmpty || activity.isEmpty)
            }
            .navigationTitle("TravelMate Planner")
        }
        .onAppear {
            destination = defaultDestination
            activity = defaultActivity
        }
        .sheet(isPresented: $showSummary) {
            SummaryView(
                itinerary: Itinerary(destination: destination, startDate: startDate, endDate: endDate, activity: activity),
                dismissAction: {
                    showSummary = false
                }
            )
        }
    }
}

