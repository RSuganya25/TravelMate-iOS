import SwiftUI

struct SummaryView: View {
    var itinerary: Itinerary
    var dismissAction: () -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Your Travel Plan")
                        .font(.largeTitle)
                        .padding()
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("Destination: \(itinerary.destination)")
                    Text("From: \(formattedDate(itinerary.startDate))")
                    Text("To: \(formattedDate(itinerary.endDate))")
                    Text("Activities: \(itinerary.activity)")
                    
                    Image("Adventure")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .accessibilityHidden(true)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                dismissAction()
            })
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

