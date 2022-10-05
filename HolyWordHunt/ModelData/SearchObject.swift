//
//  SearchObject.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/3/22.
//

import Foundation

// Object that is used to save/display saved searches
struct Search: Identifiable {
    
    var id: Int
    var word: String
    var wordCount: Int
    var totalVerseCount: Int
    var oldTestament: Bool
    var newTestament: Bool
    var bookOfMormon: Bool
    var doctrineAndCovenants: Bool
    var pearlOfGreatPrice: Bool
    
    init(id: Int, word: String, wordCount: Int, totalVerseCount: Int, oldTestament: Bool, newTestament: Bool,
         bookOfMormon: Bool, doctrineAndCovenants: Bool, pearlOfGreatPrice: Bool)
    {
        self.id = id
        self.word = word
        self.wordCount = wordCount
        self.totalVerseCount = totalVerseCount
        self.oldTestament = oldTestament
        self.newTestament = newTestament
        self.bookOfMormon = bookOfMormon
        self.doctrineAndCovenants = doctrineAndCovenants
        self.pearlOfGreatPrice = pearlOfGreatPrice
    }
        
    // Function that turns boolean book values into a string
    func booksToString() -> String
    {
        var books = ""
        if (oldTestament) {
            books += "OT, "
        }
        if (newTestament) {
            books += "NT, "
        }
        if (bookOfMormon) {
            books += "BOM, "
        }
        if (doctrineAndCovenants) {
            books += "D&C, "
        }
        if (pearlOfGreatPrice) {
            books += "PGP, "
        }
        
        if (books.count > 2) { // Remove the comma and space at the end as long as there is some value
            books.remove(at: books.index(before: books.endIndex))
            books.remove(at: books.index(before: books.endIndex))
        }
        
        return books
    }
    
}
