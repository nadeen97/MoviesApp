import Foundation
import SQLite3

class DataBaseHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }
    init(x : String)
    {
        db = openDatabase()
        createTablePosters()
        
    }
    func createTablePosters() {
           let createTableString = "CREATE TABLE IF NOT EXISTS Posters(movId TEXT PRIMARY KEY,movPoster TEXT);"
           var createTableStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
           {
               if sqlite3_step(createTableStatement) == SQLITE_DONE
               {
                   print("posters table created.")
               } else {
                   print("posters table could not be created.")
               }
           } else {
               print("CREATE TABLE statement could not be prepared.")
           }
           sqlite3_finalize(createTableStatement)
       }
    
    
    
    
    func readTbalePosters() -> [Movie] {
         let queryStatementString = "SELECT * FROM posters;"
         var queryStatement: OpaquePointer? = nil
         var psns : [Movie] = []
         if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
             while sqlite3_step(queryStatement) == SQLITE_ROW {
                 let movId = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                 let movPosterPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))

                 
                 psns.append(Movie(mvId: movId, mvPostePath: movPosterPath))
                 print("Query Result:")
                 print("\(movId)  | \(movPosterPath)")
             }
         } else {
             print("SELECT statement could not be prepared")
         }
         sqlite3_finalize(queryStatement)
         return psns
     }
    
    
    func insertPosters(movId:String, movPosterPath:String )
       {
           let movies = read()
           for m in movies
           {
               if m.mId == movId
               {
                   return
               }
           }
           let insertStatementString = "INSERT INTO posters (movId ,movPosterPath  ) VALUES (?, ?);"
           var insertStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               sqlite3_bind_text(insertStatement, 1, (movId as NSString).utf8String, -1, nil)
               sqlite3_bind_text(insertStatement, 2, (movPosterPath as NSString).utf8String, -1, nil)
              
               if sqlite3_step(insertStatement) == SQLITE_DONE {
                   print("Successfully inserted row.")
               } else {
                   print("Could not insert row.")
               }
           } else {
               print("INSERT statement could not be prepared.")
           }
           sqlite3_finalize(insertStatement)
      }
//
//       func read() -> [Movie] {
//          let queryStatementString = "SELECT * FROM movies;"
//          var queryStatement: OpaquePointer? = nil
//          var psns : [Movie] = []
//          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//              while sqlite3_step(queryStatement) == SQLITE_ROW {
//                  let movId = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
//                  let movTitle = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                  let movPosterPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
//
//                   let movOverView = "String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))"
//                   let movRelDate = "String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))"
//                   let movVoteAvg = "String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))"
//                   let movPopularity = "String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))"
//
//
//
//                  psns.append(Movie(mvId: movId, mvTitle: movTitle, mvPostePath: movPosterPath, mvOverView: movOverView, mvReleasDate: movRelDate, mvVoteAvg: movVoteAvg, mvPopularity: movPopularity))
//                  print("Query Result:")
//                  print("\(movId) | \(movTitle) | \(movPosterPath)")
//              }
//          } else {
//              print("SELECT statement could not be prepared")
//          }
//          sqlite3_finalize(queryStatement)
//          return psns
//      }
    
      
          func deleteByID(id:Int) {
              let deleteStatementStirng = "DELETE FROM movies WHERE Id = ?;"
              var deleteStatement: OpaquePointer? = nil
              if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                  sqlite3_bind_int(deleteStatement, 1, Int32(id))
                  if sqlite3_step(deleteStatement) == SQLITE_DONE {
                      print("Successfully deleted row.")
                  } else {
                      print("Could not delete row.")
                  }
              } else {
                  print("DELETE statement could not be prepared")
              }
              sqlite3_finalize(deleteStatement)
          }
    
    

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS movies(movId TEXT PRIMARY KEY,movTitle TEXT,movPosterPath TEXT ,movOverView Text ,movRelDate TEXT ,movVoteAvg TEXT ,movPopularity TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("movies table created.")
            } else {
                print("movies table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertImage( movId:String,imageDecode : String)  {
          let movies = read()
          for m in movies
          {
              if m.mId == movId
              {
                  return
              }
          }
          let insertStatementString = "UPDATE movies SET movPosterPath =  \(imageDecode) WHERE movId = \(movId);"
        var insertStatement: OpaquePointer? = nil
                if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                    sqlite3_bind_text(insertStatement, 1, (movId as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 2, (imageDecode as NSString).utf8String, -1, nil)

                    if sqlite3_step(insertStatement) == SQLITE_DONE {
                        print("Successfully inserted row.")
                    } else {
                        print("Could not insert row.")
                    }
                } else {
                    print("INSERT statement could not be prepared.")
                }
                sqlite3_finalize(insertStatement)
      }
    
    func readImage() -> [String] {
          let queryStatementString = "SELECT movPosterPath FROM movies;"
          var queryStatement: OpaquePointer? = nil
          var psns : [String] = []
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
              while sqlite3_step(queryStatement) == SQLITE_ROW {
                 
                  let movPosterPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                 psns.append(movPosterPath)
                  print("Query Result:")
                  print("\(movPosterPath)")
              }
          } else {
              print("SELECT statement could not be prepared")
          }
          sqlite3_finalize(queryStatement)
          return psns
      }
    
    
    func insert(movId:String, movTitle:String, movPosterPath:String ,movOverView :String ,movRelDate :String ,movVoteAvg :String ,movPopularity :String)
     {
         let movies = read()
         for m in movies
         {
             if m.mId == movId
             {
                 return
             }
         }
         let insertStatementString = "INSERT INTO movies (movId ,movTitle ,movPosterPath ,movOverView  ,movRelDate ,movVoteAvg ,movPopularity ) VALUES (?, ?, ? , ? , ? , ? , ?);"
         var insertStatement: OpaquePointer? = nil
         if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
             sqlite3_bind_text(insertStatement, 1, (movId as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 2, (movTitle as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 3, (movPosterPath as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 4, (movOverView as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 5, (movRelDate as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 6, (movVoteAvg as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 7, (movPopularity as NSString).utf8String, -1, nil)
             if sqlite3_step(insertStatement) == SQLITE_DONE {
                 print("Successfully inserted row.")
             } else {
                 print("Could not insert row.")
             }
         } else {
             print("INSERT statement could not be prepared.")
         }
         sqlite3_finalize(insertStatement)
    }
    
     func read() -> [Movie] {
        let queryStatementString = "SELECT * FROM movies;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Movie] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let movId = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let movTitle = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let movPosterPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                 let movOverView = "String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))"
                 let movRelDate = "String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))"
                 let movVoteAvg = "String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))"
                 let movPopularity = "String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))"
                
                
                
                psns.append(Movie(mvId: movId, mvTitle: movTitle, mvPostePath: movPosterPath, mvOverView: movOverView, mvReleasDate: movRelDate, mvVoteAvg: movVoteAvg, mvPopularity: movPopularity))
                print("Query Result:")
                print("\(movId) | \(movTitle) | \(movPosterPath)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
  


    }
    

