////
////  DataBaseHelper.swift
////  Movies
////
////  Created by Sara Alaa on 3/16/20.
////  Copyright © 2020 ITI. All rights reserved.
////
//
//import UIKit
//import Foundation
//import SQLite3
//class DataBaseHelper {
//    init()
//    {
//        db = openDatabase()
//        createTable()
//    }
//
//    let dbPath: String = "myDb.sqlite"
//    var db:OpaquePointer?
//
//    func openDatabase() -> OpaquePointer?
//    {
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            .appendingPathComponent(dbPath)
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            print("error opening database")
//            return nil
//        }
//        else
//        {
//            print("Successfully opened connection to database at \(dbPath)")
//            return db
//        }
//    }
//
//    func createTable() {
//        let createTableString = "CREATE TABLE IF NOT EXISTS person(movId TEXT PRIMARY KEY,movTitle TEXT,movPosterPath TEXT ,movOverView Text ,movRelDate TEXT ,movVoteAvg TEXT ,movPopularity TEXT);"
//        var createTableStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
//        {
//            if sqlite3_step(createTableStatement) == SQLITE_DONE
//            {
//                print("person table created.")
//            } else {
//                print("person table could not be created.")
//            }
//        } else {
//            print("CREATE TABLE statement could not be prepared.")
//        }
//        sqlite3_finalize(createTableStatement)
//    }
//
//
//    func insert(movId:String, movTitle:String, movPosterPath:String ,movOverView :String ,movRelDate :String ,movVoteAvg :String ,movPopularity :String)
//    {
//        let persons = read(Int32, UnsafeMutableRawPointer?, Int)
//        for p in persons
//        {
//            if p.mId == movId
//            {
//                return
//            }
//        }
//        let insertStatementString = "INSERT INTO person (movId ,movTitle ,movPosterPath ,movOverView Text ,movRelDate ,movVoteAvg ,movPopularity ) VALUES (?, ?, ?);"
//        var insertStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_text(insertStatement, 2, (movId as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (movTitle as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (movPosterPath as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (movOverView as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (movRelDate as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (movVoteAvg as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, (movPopularity as NSString).utf8String, -1, nil)
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
//        } else {
//            print("INSERT statement could not be prepared.")
//        }
//        sqlite3_finalize(insertStatement)
//    
//
//    func read() -> [Movie] {
//        let queryStatementString = "SELECT * FROM person;"
//        var queryStatement: OpaquePointer? = nil
//        var psns : [Movie] = []
//        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                let id = sqlite3_column_int(queryStatement, 0)
//                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let year = sqlite3_column_int(queryStatement, 2)
//                psns.append(Movie(mvId: movId, mvTitle: movTitle, mvPostePath: movPosterPath, mvOverView: movOverView, mvReleasDate: movRelDate, mvVoteAvg: movVoteAvg, mvPopularity: movPopularity))
//                print("Query Result:")
//                print("\(id) | \(name) | \(year)")
//            }
//        } else {
//            print("SELECT statement could not be prepared")
//        }
//        sqlite3_finalize(queryStatement)
//        return psns
//    }
//
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
//
//}
//}
//
//
//
//
//
//
