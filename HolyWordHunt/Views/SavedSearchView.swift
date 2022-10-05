//
//  SavedSearchView.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/1/22.
//

import SwiftUI

struct SavedSearchView: View {
    
    @StateObject var modelData = SavedSearchModelData()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Text("")
                .padding(.top, 50) // Used to push the view down below nav bar
            
            ForEach (modelData.savedSearches) { Search in
                SavedSearchRow(search: Search)
                    .onTapGesture{} // Used to keep scrolling smooth, but still allow a long press to delete
                    .onLongPressGesture {
                        modelData.deleteSavedSearch(id: Search.id)
                        modelData.updateSavedSearches()
                    }
            }
            
        } // ScrollView
        .frame(maxWidth: .infinity)
        .overlay(NavigationBar(title: "Saved Searches"))
        .onAppear{modelData.updateSavedSearches()}
        
    } // Body
    
} // View

struct SavedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSearchView()
    }
}
