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
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Destination", text: $destination)
                        .autocapitalization(.words)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    TextField("Activity Preferences", text: $activity)
                        .autocapitalization(.words)
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.vertical, 4)
                }

                Button("Create Itinerary") {
                    if validateInputs() {
                        let newItinerary = Itinerary(destination: destination.trimmingCharacters(in: .whitespacesAndNewlines),
                                                    startDate: startDate,
                                                    endDate: endDate,
                                                    activity: activity.trimmingCharacters(in: .whitespacesAndNewlines))
                        itineraryViewModel.itineraries.append(newItinerary)
                        showSummary = true
                        clearForm()
                    }
                }
                .disabled(!isFormValid())
                .padding()
                .background(isFormValid() ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationTitle("TravelMate Planner")
            .onAppear {
                destination = defaultDestination != "Select Destination" ? defaultDestination : ""
                activity = defaultActivity != "Select Activity" ? defaultActivity : ""
            }
            .sheet(isPresented: $showSummary) {
                SummaryView(itinerary: Itinerary(destination: destination, startDate: startDate, endDate: endDate, activity: activity)) {
                    showSummary = false
                }
            }
        }
    }

    private func validateInputs() -> Bool {
        errorMessage = ""

        if destination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter a valid destination."
            return false
        }
        if activity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter activity preferences."
            return false
        }
        if startDate > endDate {
            errorMessage = "Start date must be before or same as end date."
            return false
        }

        return true
    }

    private func isFormValid() -> Bool {
        !destination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !activity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        startDate <= endDate
    }

    private func clearForm() {
        destination = ""
        activity = ""
        startDate = Date()
        endDate = Date()
        errorMessage = ""
    }
}

