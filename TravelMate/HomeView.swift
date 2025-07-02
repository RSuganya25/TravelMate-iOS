import SwiftUI

// Define a route enum for navigation
enum Route: Hashable {
    case createItinerary
    case viewItineraries
}

struct HomeView: View {
    @StateObject var itineraryViewModel = ItineraryViewModel()

    @State private var selectedDestination = "Paris"
    @State private var selectedActivity = "Sightseeing"
    @State private var path = NavigationPath()

    let destinations = ["Paris", "New York", "Tokyo", "Sydney", "Dubai"]
    let activities = ["Sightseeing", "Hiking", "Beach", "Food Tour", "Shopping"]

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Welcome to TravelMate")
                    .font(.largeTitle)
                    .bold()

                Picker("Select Destination", selection: $selectedDestination) {
                    ForEach(destinations, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Picker("Select Activity", selection: $selectedActivity) {
                    ForEach(activities, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Button("Create Itinerary") {
                    path.append(Route.createItinerary)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("View Saved Itineraries") {
                    path.append(Route.viewItineraries)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .createItinerary:
                    ContentView(
                        itineraryViewModel: itineraryViewModel,
                        defaultDestination: selectedDestination,
                        defaultActivity: selectedActivity
                    )
                case .viewItineraries:
                    ItineraryListView(itineraryViewModel: itineraryViewModel)
                }
            }
        }
    }
}

