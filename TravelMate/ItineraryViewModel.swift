import Foundation
import Combine

class ItineraryViewModel: ObservableObject {
    @Published var itineraries: [Itinerary] = [] {
        didSet {
            saveItineraries()
        }
    }

    private let storageKey = "TravelMate.itineraries"

    init() {
        loadItineraries()
    }

    func saveItineraries() {
        if let encoded = try? JSONEncoder().encode(itineraries) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    func loadItineraries() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Itinerary].self, from: savedData) {
            itineraries = decoded
        }
    }
}

