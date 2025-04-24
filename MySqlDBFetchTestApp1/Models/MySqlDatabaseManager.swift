//
//  MySqlDatabaseManager.swift
//  Models_Library
//
//  Created by Daryl Cox on 04/24/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import MySQLKit

class MySqlDatabaseManager
{

    struct ClassInfo
    {

        static let sClsId        = "MySqlDatabaseManager"
        static let sClsVers      = "v1.0104"
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

