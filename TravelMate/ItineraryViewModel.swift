import Foundation

class ItineraryViewModel: ObservableObject {
    @Published var itineraries: [Itinerary] = []
    @Published var selectedItinerary: Itinerary? = nil
    
    func addItinerary(destination: String, startDate: Date, endDate: Date, activity: String) {
        let newItinerary = Itinerary(destination: destination, startDate: startDate, endDate: endDate, activity: activity)
        itineraries.append(newItinerary)
    }
    
    func selectItinerary(_ itinerary: Itinerary) {
        selectedItinerary = itinerary
    }
    
    func clearSelection() {
        selectedItinerary = nil
    }
}

