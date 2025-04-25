//
//  AppMySqlDataView.swift
//  JustAMultiplatformClock1
//
//  Created by Daryl Cox on 08/24/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import MySQLKit

@available(iOS 14.0, *)
struct AppMySqlDataView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppMySqlDataView"
        static let sClsVers      = "v1.0205"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright © JustMacApps 2023-2025. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

    @Environment(\.presentationMode) var presentationMode

    @State      private var isAppRunSQLStatementAlertShowing:Bool     = false
  
    @State      private var sSqlSelectStatement:String                = 
                            "select * from visit where tid = 261 and vdate between \"2025-04-22\" and \"2025-04-25\" and type != 32;"

                        var mySqlDatabaseManager:MySqlDatabaseManager = MySqlDatabaseManager.ClassSingleton.appMySqlDatabaseManager
//                      var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of init().

    private func xcgLogMsg(_ sMessage:String)
    {

    //  if (self.jmAppDelegateVisitor.bAppDelegateVisitorLogFilespecIsUsable == true)
    //  {
    //  
    //      self.jmAppDelegateVisitor.xcgLogMsg(sMessage)
    //  
    //  }
    //  else
    //  {
    //  
        print("\(sMessage)")
    //  
    //  }

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    var body: some View 
    {
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body' \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)...")
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body' 'self.mySqlDatabaseManager' is [\(self.mySqlDatabaseManager.toString())]...")

        VStack
        {

            Spacer()

            HStack(alignment:.center)
            {

                Spacer()

                Button
                {

                    let _ = xcgLogMsg("\(ClassInfo.sClsDisp):Button(Xcode).'Dismiss' pressed...")

                    self.presentationMode.wrappedValue.dismiss()

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "xmark.circle")
                            .help(Text("Dismiss this Screen"))
                            .imageScale(.small)

                        Text("Dismiss")
                            .font(.caption2)

                    }

                }
                .padding()
            #if os(macOS)
                .buttonStyle(.borderedProminent)
            //  .background(???.isPressed ? .blue : .gray)
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            #endif

            }

            Spacer()

            if #available(iOS 17.0, *)
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal)
                        { size, axis in
                            size * 0.080
                        }

            }
            else
            {

                Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                    .resizable()
                    .scaledToFit()
                    .frame(width:80, height: 80, alignment:.center)

            }

            Spacer()

            Text("\(JmXcodeBuildSettings.jmAppDisplayName)")
                .bold()
            Text("")
            Text("...placeholder...")
                .bold()
                .italic()

            Spacer()

            HStack(alignment:.center)
            {

                Spacer()

                Button
                {

                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):Button(Xcode).'Run SQL Statement' pressed...")

                    self.isAppRunSQLStatementAlertShowing.toggle()

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "figure.run.circle")
                            .help(Text("Run the 'test' SQL statement..."))
                            .imageScale(.large)

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text("Run SQL...")
                                .font(.caption)
                                .foregroundColor(.red)

                            Spacer()

                        }

                    }

                }
            //  .alert(selectedReportValues.sSelectedReportAlertTitle,
            //         isPresented:$isAppRunBigTestRunReportShowing,
            //         presenting: selectedReportValues)
                .alert("Run the 'test' SQL statement?", isPresented:$isAppRunSQLStatementAlertShowing)
                {

                    Button("Cancel", role:.cancel)
                    {
                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'run' the SQL statement - resuming...")
                    }
                    Button("Ok")
                    {

                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'run' the SQL statement - running...")

                        Task
                        {
                            
                            await self.executeMySqlTestStatement()
                            
                        }
                        
                    //  self.presentationMode.wrappedValue.dismiss()

                    }

                }
            //  message:
            //  { selected in
            //
            //      Text(selected.sSelectedReportAlertMessage)
            //
            //  }
            #if os(macOS)
                .buttonStyle(.borderedProminent)
            //  .background(???.isPressed ? .blue : .gray)
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            #endif

            }

            Spacer()

        }
        .padding()
        
    }

    private func executeMySqlTestStatement() async
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Issue the 'test' SQL 'query' statement and display the results in the log...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling 'self.mySqlDatabaseManager.executeQuery(query:)' with a SQL 'test' statement 'self.sSqlSelectStatement' of [\(self.sSqlSelectStatement)]...")

        do
        {
            
            let mySqlResultRows:[MySQLRow] = try await self.mySqlDatabaseManager.executeQuery(query:self.sSqlSelectStatement)
            
            self.xcgLogMsg("\(sCurrMethodDisp) Called  'self.mySqlDatabaseManager.executeQuery(query:)' with a SQL 'test' statement 'self.sSqlSelectStatement' of [\(self.sSqlSelectStatement)] with returned result(s) 'mySqlResultRows' of [\(mySqlResultRows)]...")
            
        }
        catch
        {
            
            self.xcgLogMsg("\(sCurrMethodDisp) Called  'self.mySqlDatabaseManager.executeQuery(query:)' with a SQL 'test' statement 'self.sSqlSelectStatement' of [\(self.sSqlSelectStatement)] -  statement execution failed...")
            
        }
        
        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func executeMySqlTestStatement() async.
    
}   // End of struct AppMySqlDataView(View). 

@available(iOS 14.0, *)
#Preview
{
    
    AppMySqlDataView()
    
}

