//
//  SavedSearchView.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI

struct SavedSearchView: View {
    @StateObject var viewModel = SavedSearchModelData()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("")
                .padding(.top, 50)
            ForEach (viewModel.savedSearches) { Search in
                SavedSearchRow(search: Search)
                    .onLongPressGesture {
                        viewModel.deleteSavedSearch(id: Search.id)
                        viewModel.updateSavedSearches()
                    }
                    
            }
            
        }
        .overlay(NavigationBar(title: "Saved Searches"))
        .onAppear{viewModel.updateSavedSearches()}
    }
}

struct SavedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSearchView()
    }
}
