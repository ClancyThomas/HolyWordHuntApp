//
//  ContentView.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SavedSearchView()
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
        BaseView()
    }
}
