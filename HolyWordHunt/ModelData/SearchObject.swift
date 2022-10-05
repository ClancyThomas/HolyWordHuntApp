//
//  SearchObject.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/3/22.
//

import Foundation

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
    var booksString: String
    
    init(id: Int, word: String, wordCount: Int, totalVerseCount: Int, oldTestament: Bool, newTestament: Bool,
         bookOfMormon: Bool, doctrineAndCovenants: Bool, pearlOfGreatPrice: Bool) {
        self.id = id
        self.word = word
        self.wordCount = wordCount
        self.totalVerseCount = totalVerseCount
        self.oldTestament = oldTestament
        self.newTestament = newTestament
        self.bookOfMormon = bookOfMormon
        self.doctrineAndCovenants = doctrineAndCovenants
        self.pearlOfGreatPrice = pearlOfGreatPrice
        self.booksString = booksToString()
        
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
        if (books.count > 2) {
            books.remove(at: books.index(before: books.endIndex))
            books.remove(at: books.index(before: books.endIndex))
        }
        return books
    }
        
    }
}
