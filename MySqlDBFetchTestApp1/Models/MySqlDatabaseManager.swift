//
//  MySqlDatabaseManager.swift
//  Models_Library
//
//  Created by Daryl Cox on 04/24/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

// ==========================================================================================================
//
//  ----
//  NOTE:
//  ----
//
//  This MySql DB Manager is built on 'mysql-kit' on GitHub
//      > https://github.com/vapor/mysql-kit.git
//
//  The framework it uses takes a small 'test' app from ~65 build steps under Xcode
//  to ~1425 build steps. I was looking at REST as a way to reduce the build size
//  and build time of the app. The package also pulls 'mysql-nio' and that stack pulls
//  a total of 14 packages (it's a Vapor stack).
//
//  Claude:
//  ------
//
//      Based on my search, there is a lighter-weight alternative to 'mysql-kit' you could consider:
//
//          - OHMySQL - Potentially Lighter Option
//
//                OHMySQL is a Swift + MySQL library that supports iOS, macOS and Mac Catalyst.
//
//                    > Swift Package Index: https://swiftpackageindex.com/vapor/mysql-kit
//                    > GitHub link(s):      https://github.com/oleghnidets/OHMySQL
//                                           https://github.com/oleghnidets/OHMySQL/tree/master
//
//                          <<< The library in GitHub also has a 'demo' Sample App... >>>
//
//                The library supports Objective-C and Swift, iOS and macOS, and allows you to
//                connect to your remote MySQL database using OHMySQL API in an easy and
//                object-oriented way.
//
//                    > Connecting iOS App to MySql DB:
//                          https://medium.com/@joseortizcosta/connecting-ios-app-to-mysql-database-with-swift-5-using-protocol-delegation-and-mvc-architectural-259dc32fcc4b
//
//                Key advantages:
//                --------------
//
//                    - It's described as "The Objective-C wrapper for mysqlclient (MySQL C API)" 
//                    - Likely has fewer dependencies than the Vapor stack
//                    - More direct approach without the event-driven networking stack
//
//                The Problem with 'mysql-kit'
//                ----------------------------
//
//                    The reason 'mysql-kit pulls' 14 packages is because it's part of the Vapor ecosystem:
//
//                        - mysql-kit → mysql-nio → SwiftNIO → async-kit → sql-kit → fluent-kit, etc.
//                        - It's designed for high-performance server applications, not mobile apps
//                        - The entire SwiftNIO event-driven networking stack is overkill for iOS
//
//                Recommended Approach
//                --------------------
//
//                    Given your constraints (no server-side control, need to reduce build time), 
//                    I'd suggest:
//
//                        1. Try OHMySQL first - 
//                               It's likely much lighter since it's a direct wrapper around MySQL C API
//                        2. If OHMySQL doesn't work,
//                               seriously consider the REST API approach with URLSession -
//                               it would get you back to ~65 build steps
//
//                Simple comparison:
//                -----------------
//
//                    - mysql-kit:         14 packages, ~1425 build steps
//                    - OHMySQL:           Likely 1-3 packages, significantly fewer build steps
//                    - URLSession + REST: 0 additional packages, ~65 build steps
//
// ==========================================================================================================

import Foundation
import SwiftUI
import MySQLKit

class MySqlDatabaseManager
{

    struct ClassInfo
    {

        static let sClsId        = "MySqlDatabaseManager"
        static let sClsVers      = "v1.0401"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // Class 'singleton' instance:

    struct ClassSingleton
    {

        static var appMySqlDatabaseManager:MySqlDatabaseManager = MySqlDatabaseManager()

    }

    // 'Internal' Trace flag:

    private 
    var bInternalTraceFlag:Bool                                 = false

    // App Data field(s):

    var connectionPool:EventLoopGroupConnectionPool<MySQLConnectionSource>
    
    private init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  super.init()

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
        // Configure the MySQL connection...

        let configuration = MySQLConfiguration(hostname:        "173.194.83.155",
                                               port:            3306,
                                               username:        "root",
                                               password:        "root@pts",
                                               database:        "ptsdb",
                                               tlsConfiguration:.makeClientConfiguration())
        
        // Create a connection pool...

        self.connectionPool = EventLoopGroupConnectionPool(source:                    MySQLConnectionSource(configuration:configuration),
                                                           maxConnectionsPerEventLoop:1,
                                                           on:                        MultiThreadedEventLoopGroup(numberOfThreads:1).next())

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private override init().

    private func xcgLogMsg(_ sMessage:String)
    {

    //  if (self.jmAppDelegateVisitor != nil)
    //  {
    //
    //      if (self.jmAppDelegateVisitor!.bAppDelegateVisitorLogFilespecIsUsable == true)
    //      {
    //
    //          self.jmAppDelegateVisitor!.xcgLogMsg(sMessage)
    //
    //      }
    //      else
    //      {
    //
    //          print("\(sMessage)")
    //
    //          self.listPreXCGLoggerMessages.append(sMessage)
    //
    //      }
    //
    //  }
    //  else
    //  {
    //
        print("\(sMessage)")
    //
    //      self.listPreXCGLoggerMessages.append(sMessage)
    //
    //  }

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    public func toString() -> String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bInternalTraceFlag': [\(String(describing: self.bInternalTraceFlag))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'connectionPool': [\(String(describing: self.connectionPool))]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    func executeQuery(query:String) async throws->[MySQLRow] 
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'query' is [\(query)]...")
        
        // Return the result(s) of the supplied 'query' string...
        
        let mysql = self.connectionPool.database(logger:Logger(label:"xxx"))
        let rows  = try await mysql.simpleQuery(query).get()
        
        return rows

    //  return try await self.connectionPool.withConnection
    //  { conn in
    //
    //      try await conn.query(query).get()
    //
    //  }

    }   // End of func executeQuery(query:String) async throws->[MySQLRow].

}   // End of struct DatabaseManager.

extension MySQLRow
{

    func toDictionary()->[String:Any]
    {

        var dictMySQLResultRow:[String:Any] = [String:Any]()

        for i in 0..<self.columnDefinitions.count
        {

            let sColumnName:String = self.columnDefinitions[i].name

            // Get the data directly using the subscript with the column name...

            if let mySQLData:MySQLData = self.column(sColumnName)
            {

                // Extract value from MySQLData and add to dictionary...

                if let string = mySQLData.string
                {
                    dictMySQLResultRow[sColumnName] = string
                }
                else if let int = mySQLData.int
                {
                    dictMySQLResultRow[sColumnName] = int
                }
                else if let double = mySQLData.double
                {
                    dictMySQLResultRow[sColumnName] = double
                }
                else if let bool = mySQLData.bool
                {
                    dictMySQLResultRow[sColumnName] = bool
                }
                else if let date = mySQLData.date
                {
                    dictMySQLResultRow[sColumnName] = date
                }
                else if let bytes = mySQLData.buffer
                {
                    dictMySQLResultRow[sColumnName] = bytes
                }
                else if let decimal = mySQLData.decimal
                {
                    dictMySQLResultRow[sColumnName] = decimal
                }
//                else if let json = mySQLData.json(as:MySQLData.self)
//                {
//                    dictMySQLResultRow[sColumnName] = json
//                }
//                else if mySQLData.isNull
//                {
//                    dictMySQLResultRow[sColumnName] = NSNull()
//                }

            }

        }

        return dictMySQLResultRow

    }   // End of func toDictionary()->[String:Any].

}   // End of extension MySQLRow.

// ----------------------------------------------------------------------------------------------------------
//
//  <<< 5th Attempt >>>
//
//  extension MySQLRow
//  {
//
//      func toDictionary()->[String:Any] 
//      {
//
//          var result:[String:Any] = [String:Any]()
//          
//          // Access the column definitions and values...
//
//          let columns = self.metadata.columns
//          
//          self.
//          
//          for index in 0..<columns.count 
//          {
//
//              let columnName = columns[index].name
//              
//              // Use decodeNil, decode, etc., for accessing values...
//              
//              let mySQLData:MySQLData? = self.column(columnName)
//              
//              mySQLData.
//
//              do 
//              {
//
//                  if try self.decodeNil(column: columnName) 
//                  {
//                      result[columnName] = NSNull()
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: String.self) 
//                  {
//                      result[columnName] = value
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: Int.self) 
//                  {
//                      result[columnName] = value
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: Double.self) 
//                  {
//                      result[columnName] = value
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: Bool.self) 
//                  {
//                      result[columnName] = value
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: Date.self) 
//                  {
//                      result[columnName] = value
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: Data.self) 
//                  {
//                      result[columnName] = value
//                  } 
//                  else if let value = try? self.decode(column: columnName, as: MySQLData.self) 
//                  {
//                      // Use MySQLData's properties as a fallback...
//
//                      if value.buffer != nil 
//                      {
//                          result[columnName] = value
//                      }
//
//                  }
//
//              } 
//              catch 
//              {
//                  // Handle or ignore errors...
//
//                  print("Error decoding column \(columnName): \(error)")
//              }
//
//          }
//          
//          return result
//
//      }   // End of func toDictionary()->[String:Any].
//
//  }   // End of extension MySQLRow.
//
// ----------------------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
//
//  <<< 4th Attempt >>>
//
//  extension MySQLRow 
//  {
//
//      func toDictionary()->[String:Any] 
//      {
//
//          var result:[String:Any] = [String:Any]()
//          
//          for i in 0..<self.columnDefinitions.count 
//          {
//
//              let columnName = self.columnDefinitions[i].name
//              
//              // Get the data directly using the subscript with the column name...
//
//              if let data = column(at:i)
//              {
//
//                  // Extract value from MySQLData and add to dictionary...
//
//                  if let string = data.string 
//                  {
//                      result[columnName] = string
//                  } 
//                  else if let int = data.int 
//                  {
//                      result[columnName] = int
//                  } 
//                  else if let double = data.double 
//                  {
//                      result[columnName] = double
//                  } 
//                  else if let bool = data.bool 
//                  {
//                      result[columnName] = bool
//                  } 
//                  else if let date = data.date 
//                  {
//                      result[columnName] = date
//                  } 
//                  else if let bytes = data.data 
//                  {
//                      result[columnName] = bytes
//                  } 
//                  else if let decimal = data.decimal 
//                  {
//                      result[columnName] = decimal
//                  } 
//                  else if let json = data.json 
//                  {
//                      result[columnName] = json
//                  } 
//                  else if data.isNull 
//                  {
//                      result[columnName] = NSNull()
//                  }
//
//              }
//
//          }
//          
//          return result
//
//      }   // End of func toDictionary()->[String:Any].
//
//  }   // End of extension MySQLRow.
//
// ----------------------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
//
//  <<< 3rd Attempt >>>
//
//  extension MySQLRow 
//  {
//
//      func toDictionary()->[String:Any] 
//      {
//
//          var result:[String:Any] = [String:Any]()
//          
//          // Access the columns from MySQLProtocol.ColumnDefinition41...
//
//          for column in self.columnDefinitions 
//          {
//
//              let columnName = column.name
//              
//              // Use the column index to access the data...
//
//              if let index = self.columnDefinitions.firstIndex(where:{ $0.name == columnName }),
//                 let data  = self.column(index) 
//              {
//                  
//                  // Extract value from MySQLData and add to dictionary...
//
//                  if let string = data.string 
//                  {
//                      result[columnName] = string
//                  } 
//                  else if let int = data.int 
//                  {
//                      result[columnName] = int
//                  } 
//                  else if let double = data.double 
//                  {
//                      result[columnName] = double
//                  } 
//                  else if let bool = data.bool 
//                  {
//                      result[columnName] = bool
//                  } 
//                  else if let date = data.date 
//                  {
//                      result[columnName] = date
//                  } 
//                  else if let data = data.data 
//                  {
//                      result[columnName] = data
//                  } 
//                  else if let decimal = data.decimal 
//                  {
//                      result[columnName] = decimal
//                  } 
//                  else if let json = data.json 
//                  {
//                      result[columnName] = json
//                  } 
//                  else if data.isNull 
//                  {
//                      result[columnName] = NSNull()
//                  }
//
//              }
//
//          }
//          
//          return result
//
//      }   // End of func toDictionary()->[String:Any].
//
//  }   // End of extension MySQLRow.
//
// ----------------------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
//
//  <<< 2nd Attempt >>>
//
//  extension MySQLRow 
//  {
//
//      func toDictionary()->[String:Any] 
//      {
//
//          var result:[String:Any] = [String:Any]()
//          
//          // Use the columns property to get column names...
//
//          for column in self.columns 
//          {
//
//              let columnName = column.name
//
//              if let value = self[column.name] 
//              {
//
//                  // Extract value from MySQLData and add to dictionary..
//
//                  if let string = value.string 
//                  {
//                      result[columnName] = string
//                  } 
//                  else if let int = value.int 
//                  {
//                      result[columnName] = int
//                  } 
//                  else if let double = value.double 
//                  {
//                      result[columnName] = double
//                  } 
//                  else if let bool = value.bool 
//                  {
//                      result[columnName] = bool
//                  } 
//                  else if let date = value.date 
//                  {
//                      result[columnName] = date
//                  } 
//                  else if let data = value.data 
//                  {
//                      result[columnName] = data
//                  } 
//                  else if value.isNull 
//                  {
//                      result[columnName] = NSNull()
//                  }
//
//                  // Add other data types as needed...
//
//              }
//
//          }
//          
//          return result
//
//      }   // End of func toDictionary()->[String:Any].
//
//  }   // End of extension MySQLRow.
//
// ----------------------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------
//
//  <<< 1st Attempt >>>
//
//  extension MySQLRow 
//  {
//
//      func toDictionary()->[String:Any] 
//      {
//
//          var result:[String:Any] = [String:Any]()
//          
//          for (columnName, columnData) in self
//          {
//
//              // Extract value from MySQLData and add to dictionary...
//
//              if let string = columnData.string
//              {
//                  result[columnName] = string
//              } 
//              else if let int = columnData.int 
//              {
//                  result[columnName] = int
//              } 
//              else if let double = columnData.double 
//              {
//                  result[columnName] = double
//              } 
//              else if let bool = columnData.bool 
//              {
//                  result[columnName] = bool
//              } 
//              else if let date = columnData.date 
//              {
//                  result[columnName] = date
//              } 
//              else if let data = columnData.data 
//              {
//                  result[columnName] = data
//              } 
//              else if columnData.isNull 
//              {
//                  result[columnName] = NSNull()
//              }
//
//              // Add other data types as needed...
//
//          }
//          
//          return result
//
//      }   // End of func toDictionary()->[String:Any].
//
//  }   // End of extension MySQLRow.
//
// ----------------------------------------------------------------------------------------------------------

