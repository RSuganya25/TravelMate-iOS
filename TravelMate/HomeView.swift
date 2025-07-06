import SwiftUI

enum Route: Hashable {
    case createItinerary
    case viewItineraries
}

struct HomeView: View {
    @StateObject var itineraryViewModel = ItineraryViewModel()

    @State private var selectedDestination = ""
    @State private var selectedActivity = ""
    @State private var path: [Route] = []
    @State private var showRecentTrips = false

    let destinations = ["Paris", "New York", "Tokyo", "Sydney", "Dubai"]
    let activities = ["Sightseeing", "Hiking", "Beach", "Food Tour", "Shopping"]
    let suggestedTrips = [
        ("Rome", "Colosseum"),
        ("London", "Museums"),
        ("Bali", "Beaches"),
        ("Kyoto", "Temples"),
        ("San Francisco", "Golden Gate")
    ]

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Image("Rome")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.top)
                        .transition(.opacity.combined(with: .slide))
                        .animation(.easeIn(duration: 0.8), value: selectedDestination)
                    
                    Text("Welcome to TravelMate")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 10)
                        .opacity(showRecentTrips ? 1 : 0)
                        .animation(.easeIn(duration: 0.6), value: showRecentTrips)

                    Text("Plan your dream trip effortlessly 🌍✈️")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)

                    VStack(spacing: 15) {
                        Picker("Select Destination", selection: $selectedDestination) {
                            Text("Select Destination").tag("")
                            ForEach(destinations, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        Picker("Select Activity", selection: $selectedActivity) {
                            Text("Select Activity").tag("")
                            ForEach(activities, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: selectedActivity)

                    Button {
                        path.append(.createItinerary)
                    } label: {
                        Text("Create Itinerary")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isSelectionValid() ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!isSelectionValid())
                    .padding(.top)

                    Button {
                        path.append(.viewItineraries)
                    } label: {
                        Text("View Saved Itineraries")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Divider()
                        .padding(.vertical, 20)

                    if showRecentTrips {
                        Text("✨ Suggested Trips")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(suggestedTrips, id: \.0) { trip in
                                    VStack(alignment: .leading) {
                                        Image(trip.0.replacingOccurrences(of: " ", with: ""))
                                            .resizable()
                                            .frame(width: 120, height: 80)
                                            .cornerRadius(8)
                                        Text(trip.0)
                                            .font(.headline)
                                        Text(trip.1)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 130)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                                    .transition(.scale)
                                }
                            }
                        }
                        .animation(.easeOut(duration: 0.7), value: showRecentTrips)
                    }

                    Spacer()
                }
                .padding()
            }
            .onAppear {
                withAnimation {
                    showRecentTrips = true
                }
            }
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

    private func isSelectionValid() -> Bool {
        !selectedDestination.isEmpty && !selectedActivity.isEmpty
    }
}
