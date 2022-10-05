//
//  ModelDataSavedSearch.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/3/22.
//

import SwiftUI


public class SavedSearchModelData: ObservableObject {
    
    @Published var savedSearches: [Search] = []
    var databaseWorker:DatabaseWorker = DatabaseWorker()
    
    
    func updateSavedSearches() -> Void {
        savedSearches = databaseWorker.queryAllSavedSearches()
    }
    
    func deleteSavedSearch(id: Int) -> Void {
        databaseWorker.deleteSearch(id: id)
    }
}



