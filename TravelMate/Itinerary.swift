import Foundation

struct Itinerary: Identifiable, Codable {
    var id: UUID
    var destination: String
    var startDate: Date
    var endDate: Date
    var activity: String

    init(id: UUID = UUID(), destination: String, startDate: Date, endDate: Date, activity: String) {
        self.id = id
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.activity = activity
    }
}

