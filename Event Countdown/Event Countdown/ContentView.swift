//
//  ContentView.swift
//  Event Countdown
//
//  Created by MAC on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to the Event Countdown App!")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: EventsView()) {
                    Text("Go to Events")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
