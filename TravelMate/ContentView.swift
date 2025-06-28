//
//  ContentView.swift
//  TravelMate
//
//  Created by Suganya Ravindran on 6/27/25.
//

import SwiftUI

struct ContentView: View {
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
                    showSummary = true
                }
                .disabled(destination.isEmpty || activity.isEmpty)
            }
            .navigationTitle("TravelMate Planner")
            .sheet(isPresented: $showSummary) {
                SummaryView(destination: destination, startDate: startDate, endDate: endDate, activity: activity)
            }
        }
    }
}

struct SummaryView: View {
    var destination: String
    var startDate: Date
    var endDate: Date
    var activity: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Travel Plan")
                .font(.largeTitle)
                .padding()

            Text("Destination: \(destination)")
            Text("From: \(formattedDate(startDate))")
            Text("To: \(formattedDate(endDate))")
            Text("Activities: \(activity)")
            
            Image("travel") // Default travel image in assets
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Spacer()
        }
        .padding()
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

