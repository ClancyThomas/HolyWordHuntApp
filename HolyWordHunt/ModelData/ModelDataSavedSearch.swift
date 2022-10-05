//
//  ModelDataSavedSearch.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/3/22.
//

import SwiftUI

// Class used to handle the saved search data and update/delete it
public class SavedSearchModelData: ObservableObject {
    
    var databaseWorker:DatabaseWorker = DatabaseWorker()
    
    @Published var savedSearches: [Search] = []
    
    func updateSavedSearches() -> Void {
        savedSearches = databaseWorker.queryAllSavedSearches()
    }
    
    func deleteSavedSearch(id: Int) -> Void {
        databaseWorker.deleteSavedSearch(id: id)
    }
}



