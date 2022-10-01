//
//  ContentView.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SearchView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            FunFactView()
                .tabItem {
                    Label("Fun Facts", systemImage: "lightbulb")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
