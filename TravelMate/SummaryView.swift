import SwiftUI

struct SummaryView: View {
    var itinerary: Itinerary
    var dismissAction: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Your Travel Plan")
                    .font(.largeTitle)
                    .padding()
                
                Text("Destination: \(itinerary.destination)")
                Text("From: \(formattedDate(itinerary.startDate))")
                Text("To: \(formattedDate(itinerary.endDate))")
                Text("Activities: \(itinerary.activity)")
                
                Image("Adventure") // Add a travel image asset in your Assets.xcassets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Spacer()
            }
            .padding()
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

