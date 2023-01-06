//
//  DatabaseWorker.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/1/22.
//

import Foundation
import SQLite3

// Handles all the actions with the SQLite3 Database
class DatabaseWorker {
    
    let databaseName = "scriptures.db"
    var database: OpaquePointer?
    
    init()
    {
        database = connectToDatabase()
        createTable()
    }
    
    // Connect with the database
    func connectToDatabase() -> OpaquePointer?
    {
        let fileManager = FileManager.default
        var database: OpaquePointer? = nil
        let fileURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent(databaseName)
       
        // Check if the file exists on local device, copy the database if it doesn't already exist
        if !fileManager.fileExists(atPath: fileURL.path) {
                print("De")
                let dbResourcePath = Bundle.main.path(forResource: "scriptures", ofType: "db")
                do {
                    try fileManager.copyItem(atPath: dbResourcePath!, toPath: fileURL.path)
                } catch {
                    print(error.localizedDescription)
                    return nil
                }
        }
        
        // Open the connection to the database
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK
        {
            print("Successfully opened connection to: \(databaseName)")
            return database
        }
        else
        {
            print("Error opening the database!")
            return nil
        }
    }
    
    // Create the table that will be used to store saved searches
    func createTable() -> Void
    {
        var query: OpaquePointer? = nil
        let createTableString =
        """
            CREATE TABLE IF NOT EXISTS saved_searches (id INTEGER PRIMARY KEY NOT NULL,
            word String, word_count INTEGER, total_verse_count INTEGER, old_testament BOOL, new_testament BOOL,
            book_of_mormon BOOL, doctrine_and_covenants BOOL, pearl_of_great_price BOOL)
        """
        
        if sqlite3_prepare_v2(database, createTableString, -1, &query, nil) == SQLITE_OK {
            if sqlite3_step(query) == SQLITE_DONE {
                print("Table created successfully!")
            } else {
                print("Table not created!")
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(database))
            print("Error: "+errMsg)
            print("Create Table was not able to work")
        }
    }
    
    // Search for a word in specified books - Count how many verses it appears in
    func queryWord(word: String, ot: Bool, nt: Bool, bom: Bool, dc: Bool, pgp: Bool) -> Int
    {
        let books = getBooks(ot: ot, nt: nt, bom: bom, dc: dc, pgp: pgp)
        let queryString = "SELECT count(*) FROM searchTable WHERE volume_id IN ("+books+") AND scripture_text MATCH ?"
        var query: OpaquePointer? = nil
        var result = 0
        
        if sqlite3_prepare_v2(database, queryString, -1, &query, nil) == SQLITE_OK {
            // Must use NSString and convert to utf8String 
            sqlite3_bind_text(query, 1, NSString(string: word).utf8String, -1, nil)
            while sqlite3_step(query) == SQLITE_ROW {
                result = Int(sqlite3_column_int(query, 0))
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(database))
            print("Error: "+errMsg)
            print("Query was not able to work")
            result = 0
        }
        
        sqlite3_finalize(query)
        
        return result
    }
    
    // Search for the total amount of verses in specified books
    func queryBooks(ot: Bool, nt: Bool, bom: Bool, dc: Bool, pgp: Bool) -> Int
    {
        let books = getBooks(ot: ot, nt: nt, bom: bom, dc: dc, pgp: pgp)
        let queryString = "SELECT count(*) FROM searchTable WHERE volume_id IN ("+books+")"
        var query: OpaquePointer? = nil
        
        var result = 0
        
        if sqlite3_prepare_v2(database, queryString, -1, &query, nil) == SQLITE_OK {
            while sqlite3_step(query) == SQLITE_ROW {
                result = Int(sqlite3_column_int(query, 0))
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(database))
            print("Error: "+errMsg)
            print("Query was not able to work")
            result = 0
        }
        
        sqlite3_finalize(query)
        
        return result
    }
    
    // Insert the data for a saved search
    func insertSavedSearch(word: String, wordCount: Int, totalVerseCount: Int, ot: Bool, nt: Bool,
                           bom: Bool, dc: Bool, pgp: Bool) -> Void
    {
        // Convert the boolean values to integers - SQLite only handles integers NOT boolean
        let flagOt = (ot) ? 1 : 0
        let flagNt = (nt) ? 1 : 0
        let flagBom = (bom) ? 1 : 0
        let flagDc = (dc) ? 1 : 0
        let flagPgp = (pgp) ? 1 : 0
        
        let insertString = "INSERT INTO saved_searches VALUES (null,?,?,?,?,?,?,?,?)"
        var insert: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, insertString, -1, &insert, nil) == SQLITE_OK {
            // Must use NSString and convert to utf8String
            sqlite3_bind_text(insert, 1, NSString(string: word).utf8String, -1, nil)
            sqlite3_bind_int64(insert, 2, sqlite3_int64(wordCount))
            sqlite3_bind_int64(insert, 3, sqlite3_int64(totalVerseCount))
            sqlite3_bind_int64(insert, 4, sqlite3_int64(flagOt))
            sqlite3_bind_int64(insert, 5, sqlite3_int64(flagNt))
            sqlite3_bind_int64(insert, 6, sqlite3_int64(flagBom))
            sqlite3_bind_int64(insert, 7, sqlite3_int64(flagDc))
            sqlite3_bind_int64(insert, 8, sqlite3_int64(flagPgp))
            if sqlite3_step(insert) == SQLITE_DONE {
                print("Insert Success!")
            } else {
                print("Insert failure!")
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(database))
            print("Error: "+errMsg)
            print("Insert was not able to work")
        }
        
        sqlite3_finalize(insert)
    }
    
    // Search for all the saved searches
    func queryAllSavedSearches() -> [Search]  {
        
        let queryString =
        """
        SELECT rowid, word, word_count, total_verse_count, old_testament, new_testament, book_of_mormon,
        doctrine_and_covenants, pearl_of_great_price FROM saved_searches
        """
        var query: OpaquePointer? = nil
        
        var savedSearches: [Search] = []
        
        if sqlite3_prepare_v2(database, queryString, -1, &query, nil) == SQLITE_OK {
            while sqlite3_step(query) == SQLITE_ROW {
                let rowid = Int(sqlite3_column_int(query, 0))
                let word = String(describing: String(cString: sqlite3_column_text(query, 1)))
                let wordCount = Int(sqlite3_column_int(query, 2))
                let totalVerseCount = Int(sqlite3_column_int(query, 3))
                let oldTestament = Int(sqlite3_column_int(query, 4)) == 0 ? false : true
                let newTestament = Int(sqlite3_column_int(query, 5)) == 0 ? false : true
                let bookOfMormon = Int(sqlite3_column_int(query, 6)) == 0 ? false : true
                let doctrineAndCovenants = Int(sqlite3_column_int(query, 7)) == 0 ? false : true
                let pearlOfGreatPrice = Int(sqlite3_column_int(query, 8)) == 0 ? false : true
                
                savedSearches.append(Search(id: rowid, word: word, wordCount: wordCount, totalVerseCount: totalVerseCount, oldTestament: oldTestament, newTestament: newTestament, bookOfMormon: bookOfMormon, doctrineAndCovenants: doctrineAndCovenants, pearlOfGreatPrice: pearlOfGreatPrice))
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(database))
            print("Error: "+errMsg)
            print("Query was not able to work")

        }
        
        sqlite3_finalize(query)

        return savedSearches
    }
    
    // Delete a saved search by id
    func deleteSavedSearch(id: Int) -> Void
    {
        let deleteString = "DELETE FROM saved_searches WHERE id = ?"
        var delete: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, deleteString, -1, &delete, nil) == SQLITE_OK {
            sqlite3_bind_int64(delete, 1, sqlite3_int64(id))
            if sqlite3_step(delete) == SQLITE_DONE {
                print("Delete Success!")
            } else {
                print("Delete failure!")
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(database))
            print("Error: "+errMsg)
            print("Delete was not able to work")
        }
        
        sqlite3_finalize(delete)
    }
    
    // Used to convert boolean values for the books into their ids within the database
    func getBooks(ot: Bool, nt: Bool, bom: Bool, dc: Bool, pgp: Bool) -> String
    {
        var books = ""
        if (ot) {
            books += "1,"
        }
        if (nt) {
            books += "2,"
        }
        if (bom) {
            books += "3,"
        }
        if (dc) {
            books += "4,"
        }
        if (pgp) {
            books += "5,"
        }
        
        if (books.count > 1) { // Remove the ending comma if there is anything concatenated
            books.remove(at: books.index(before: books.endIndex))
        }
        
        return books
    }
}
