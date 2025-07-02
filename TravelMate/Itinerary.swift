import Foundation

struct Itinerary: Identifiable {
    let id = UUID()
    var destination: String
    var startDate: Date
    var endDate: Date
    var activity: String
}

