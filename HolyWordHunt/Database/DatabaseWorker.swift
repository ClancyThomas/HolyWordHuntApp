//
//  DatabaseWorker.swift
//  HolyWordHunt
//
//  Created by Clancy Thomas on 10/1/22.
//

import Foundation
import SQLite3

class DatabaseWorker {
    
    let dbName = "scriptures.db"
    var db:OpaquePointer?
    
    init()
    {
        db = openDatabase()
    }
    
    func openDatabase() -> OpaquePointer?
    {
        let fileManager = FileManager.default
        let fileURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent(dbName)
        var db: OpaquePointer? = nil
        
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
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK
        {
            print("Successfully opened connection to database at \(dbName)")
            return db
        }
        else
        {
            print("Error opening the database!!!")
            return nil
        }
    }
    
    func queryWord(word: String, ot: Bool, nt: Bool, bom: Bool, dc: Bool, pgp: Bool) -> Int
    {
        let books = getBooks(ot: ot, nt: nt, bom: bom, dc: dc, pgp: pgp)
        let queryString = "SELECT count(*) FROM searchTable WHERE volume_id IN ("+books+") AND scripture_text MATCH ?"
        var query: OpaquePointer? = nil
        var result = 0
        if sqlite3_prepare_v2(db, queryString, -1, &query, nil) == SQLITE_OK {
            sqlite3_bind_text(query, 1, word, -1, nil)
            while sqlite3_step(query) == SQLITE_ROW {
                result = Int(sqlite3_column_int(query, 0))
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db))
            print("Error: "+errMsg)
            print("Query was not able to work")
            result = 0
        }
        sqlite3_finalize(query)
        return result
    }
    
    func queryBooks(ot: Bool, nt: Bool, bom: Bool, dc: Bool, pgp: Bool) -> Int
    {
        let books = getBooks(ot: ot, nt: nt, bom: bom, dc: dc, pgp: pgp)
        let queryString = "SELECT count(*) FROM searchTable WHERE volume_id IN ("+books+")"
        var query: OpaquePointer? = nil
        var result = 0
        if sqlite3_prepare_v2(db, queryString, -1, &query, nil) == SQLITE_OK {
            while sqlite3_step(query) == SQLITE_ROW {
                result = Int(sqlite3_column_int(query, 0))
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db))
            print("Error: "+errMsg)
            print("Query was not able to work")
            result = 0
        }
        sqlite3_finalize(query)
        return result
    }
    
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
        if (books.count > 1) {
            books.remove(at: books.index(before: books.endIndex))
        }
        return books
    }
}
