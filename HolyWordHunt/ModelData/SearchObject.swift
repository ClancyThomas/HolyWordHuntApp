//
//  SearchObject.swift
//  ScriptureWordCounter
//
//  Created by Clancy Thomas on 10/3/22.
//

import Foundation

struct Search {
    var word: String
    var wordCount: Int
    var totalVerseCount: Int
    var oldTestament: Bool
    var newTestament: Bool
    var bookOfMormon: Bool
    var doctrineAndCovenants: Bool
    var pearlOfGreatPrice: Bool
    
    init(word: String, wordCount: Int, totalVerseCount: Int, oldTestament: Bool, newTestament: Bool,
         bookOfMormon: Bool, doctrineAndCovenants: Bool, pearlOfGreatPrice: Bool) {
        self.word = word
        self.wordCount = wordCount
        self.totalVerseCount = totalVerseCount
        self.oldTestament = oldTestament
        self.newTestament = newTestament
        self.bookOfMormon = bookOfMormon
        self.doctrineAndCovenants = doctrineAndCovenants
        self.pearlOfGreatPrice = pearlOfGreatPrice
    }
}
