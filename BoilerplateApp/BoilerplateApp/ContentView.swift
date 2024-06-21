//
//  ContentView.swift
//  BoilerplateApp
//
//  Created by Gordon on 21/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: DetailView()) {
                Text("Show details")
            }
            .foregroundStyle(Color.primary)
            .fontDesign(.rounded)
            .font(.headline)
            .padding()
        }
    }
}

extension ContentView {
    struct DetailView: View {
        var body: some View {
            Text("<DetailView />")
                .font(.largeTitle)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("navigation details view")
        }
    }
}

#Preview {
    ContentView()
}
