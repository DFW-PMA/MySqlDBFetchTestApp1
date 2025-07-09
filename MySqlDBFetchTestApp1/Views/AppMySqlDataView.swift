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
        static let sClsVers      = "v1.0601"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright © JustMacApps 2023-2025. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // 'Internal' Trace flag:

    private 
    var bInternalTraceFlag:Bool                                        = false

    // App Data field(s):

    //  @Environment(\.dismiss)      var dismiss
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL)          var openURL
    @Environment(\.openWindow)       var openWindow

    enum FocusedFields
    {
       case sqlStatement
    }
    
    @FocusState  private var focusedField:FocusedFields?

    @State       private var cAppClearSqlStatementButtonPresses:Int    = 0

    @State       private var isAppClearSqlStatementShowingAlert:Bool   = false
    @State       private var isAppRunSQLStatementAlertShowing:Bool     = false
    
    @AppStorage("appSqlStatement1")
                         var sSqlSelectStatement:String                = ""

                 private var sSqlSelectStatementDefault:String         = 
                             "select * from visit where tid = 261 and vdate between \"2025-06-28\" and \"2025-07-05\" and type = 1;"

    @State       private var listMySQLResultRows:[[String:Any]]        = [[String:Any]]()

                         var mySqlDatabaseManager:MySqlDatabaseManager = MySqlDatabaseManager.ClassSingleton.appMySqlDatabaseManager
//                       var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
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

            HStack(alignment:.center)
            {

                Button
                {

                    self.cAppClearSqlStatementButtonPresses += 1

                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):AppMySqlDataView.Button(Xcode).'App Clear SQL Result(s) List'.#(\(self.cAppClearSqlStatementButtonPresses))'...")

                    self.listMySQLResultRows = [[String:Any]]()

                    self.isAppClearSqlStatementShowingAlert = true

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "clear")
                            .help(Text("Clear the SQL Result(s) List..."))
                            .imageScale(.small)

                        Text("Clear SQL Result(s)")
                            .font(.caption2)

                    }

                }
                .alert("App SQL Result(s) List has been 'Cleared'...", isPresented:$isAppClearSqlStatementShowingAlert)
                {

                    Button("Ok", role:.cancel) { }

                }
            #if os(macOS)
                .buttonStyle(.borderedProminent)
                .padding()
            //  .background(???.isPressed ? .blue : .gray)
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            #endif

                Spacer()

                if #available(iOS 17.0, *)
                {

                    Image(ImageResource(name:"Gfx/AppIcon", bundle:Bundle.main))
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal)
                            { size, axis in
                                size * 0.040
                            }

                }
                else
                {

                    Image(ImageResource(name:"Gfx/AppIcon", bundle:Bundle.main))
                        .resizable()
                        .scaledToFit()
                        .frame(width:40, height:40, alignment:.center)

                }

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

        //  Text("")
        //  Text("\(JmXcodeBuildSettings.jmAppDisplayName)")
        //      .bold()
        //  Text("")
            Text("")
            Text("SQL Statement to 'test':")
            Text("")

        //  Text("[\(self.sSqlSelectStatement)]")
            TextField("SQL Statement...", text:$sSqlSelectStatement)
            //  .font(.caption) 
                .disableAutocorrection(true)
                .focused($focusedField, equals:.sqlStatement)
                .onAppear
                {
                    if (self.sSqlSelectStatement.count < 1)
                    {
                        self.sSqlSelectStatement = self.sSqlSelectStatementDefault
                    }
                    
                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onAppear #1 - 'self.sSqlSelectStatement' is [\(self.sSqlSelectStatement)]...")

                    focusedField = nil
                }
                .onChange(of: self.sSqlSelectStatement)
                {
                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #1 - 'self.sSqlSelectStatement' is [\(self.sSqlSelectStatement)]...")

                    focusedField = .sqlStatement
                }
                .onSubmit
                {
                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onSubmit #1 - 'self.sSqlSelectStatement' is [\(self.sSqlSelectStatement)]...")

                    focusedField = .sqlStatement

                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onSubmit #1 - User pressed 'Enter' on the TextField to 'run' the SQL statement - running...")

                    Task
                    {
                        await self.executeMySqlTestStatement()
                    }
                }

            Text("")

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

                            Text("'test' the SQL Statement...")
                                .bold()
                                .font(.footnote)
                                .foregroundColor(.red)

                            Spacer()

                        }

                    }

                }
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
            #if os(macOS)
                .buttonStyle(.borderedProminent)
            //  .background(???.isPressed ? .blue : .gray)
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            #endif

            }

            Text("")

            HStack(alignment:.center)
            {

                Spacer()

                Text("The current 'result' set has")
                Text("#(\(self.listMySQLResultRows.count))")
                    .foregroundStyle((self.listMySQLResultRows.count > 0) ? .green : .red)
                Text("row(s)...")

                Spacer()

            }

            Text("")

            if (self.listMySQLResultRows.count > 0)
            {
            
                ScrollView
                {

                    VStack(alignment:.leading)
                    {

                    //  Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                        Grid(alignment:.centerFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                        {

                            // Column Headings:

                            GridRow 
                            {

                                Text("PID")
                                    .underline()
                                Text("TID")
                                    .underline()
                                Text("SID")
                                    .underline()
                                Text("Type")
                                    .underline()
                                Text("Billed")
                                    .underline()
                                Text("VDate")
                                    .underline()
                                Text("VTime")
                                    .underline()

                            }
                        //  .gridCellUnsizedAxes(.horizontal)
                            .font(.footnote)
                            .frame(maxWidth:.infinity, alignment:.center)

                            // Item Rows:

                            ForEach(0..<self.listMySQLResultRows.count, id:\.self)
                            { index in
                                
                                let dictSqlResultRow           = self.listMySQLResultRows[index]
                                let sSqlResultRowType:String   = String(describing: dictSqlResultRow["type"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\"")
                                let bSqlResultRowTypeGood:Bool = ((sSqlResultRowType == "1") ? true : false)

                                GridRow(alignment:.bottom)
                                {

                                    Text("\(String(describing: dictSqlResultRow["pid"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")
                                    Text("\(String(describing: dictSqlResultRow["tid"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")
                                    Text("\(String(describing: dictSqlResultRow["superid"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")

                                    Text("\(String(describing: dictSqlResultRow["type"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")
                                        .foregroundStyle((bSqlResultRowTypeGood == true) ? .green : .red)

                                    Text("\(String(describing: dictSqlResultRow["billed"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")

                                    Text("\(String(describing: dictSqlResultRow["vdate"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")
                                        .foregroundStyle((bSqlResultRowTypeGood == true) ? .green : .red)

                                    Text("\(String(describing: dictSqlResultRow["vstime"]).stripOptionalStringWrapper().stripStringWrapper(sWrapperCharacters:"\""))")
                                        .foregroundStyle((bSqlResultRowTypeGood == true) ? .green : .red)

                                }
                                .font(.caption2)

                            }
                            .scaledToFill()

                        }
                        .padding()

                    }
                    .frame(maxWidth:.infinity, alignment:.center)

                }
                .frame(maxWidth:.infinity, alignment:.center)
            
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

        var listMySQLResultRows:[[String:Any]] = [[String:Any]]()

        self.xcgLogMsg("\(sCurrMethodDisp) Calling 'self.mySqlDatabaseManager.executeQuery(query:)' with a SQL 'test' statement 'self.sSqlSelectStatement' of [\(self.sSqlSelectStatement)]...")

        do
        {
            
            let mySqlResultRows:[MySQLRow] = try await self.mySqlDatabaseManager.executeQuery(query:self.sSqlSelectStatement)
            
            self.xcgLogMsg("\(sCurrMethodDisp) Called  'self.mySqlDatabaseManager.executeQuery(query:)' with a SQL 'test' statement 'self.sSqlSelectStatement' of [\(self.sSqlSelectStatement)] with returned result(s) 'mySqlResultRows' of [\(mySqlResultRows)]...")
            
            self.xcgLogMsg("\(sCurrMethodDisp) Enumerating each returned 'result' Rowa' Column 'definitions'...")
            
            var cMySqlResultRows:Int = 0
            
            for mySqlResultRow in mySqlResultRows
            {
                
                cMySqlResultRows += 1

                if (self.bInternalTraceFlag == true)
                {
                
                    let listAllColumnDefinitionaInRow:[MySQLProtocol.ColumnDefinition41] = mySqlResultRow.columnDefinitions

                    var cMySqlResultRowsColumnsDefs:Int = 0

                    for mySqlResultRowColumnDefinition in listAllColumnDefinitionaInRow
                    {

                        cMySqlResultRowsColumnsDefs += 1

                        self.xcgLogMsg("\(sCurrMethodDisp) Row #(\(cMySqlResultRows)) has Column #(\(cMySqlResultRowsColumnsDefs)) defined as 'mySqlResultRowColumnDefinition' of [\(mySqlResultRowColumnDefinition)]...")

                    }
                
                    let sqlResultRow:SQLRow           = mySqlResultRow.sql()
                    let listSqlResultColumns:[String] = sqlResultRow.allColumns

                    var cMySqlResultRowsColumnsNames:Int = 0

                    for sSqlResultRowColumnName in listSqlResultColumns
                    {

                        cMySqlResultRowsColumnsNames += 1

                        self.xcgLogMsg("\(sCurrMethodDisp) Row #(\(cMySqlResultRows)) has Column #(\(cMySqlResultRowsColumnsNames)) with a name as 'sSqlResultRowColumnName' of [\(sSqlResultRowColumnName)]...")

                        let mySqlResultRowColumnValues:[ByteBuffer?] = mySqlResultRow.values

                        self.xcgLogMsg("\(sCurrMethodDisp) Row #(\(cMySqlResultRows)) has Column #(\(cMySqlResultRowsColumnsNames)) with a name as 'sSqlResultRowColumnName' of [\(sSqlResultRowColumnName)] and Column value(s) 'mySqlResultRowColumnValues' of [\(mySqlResultRowColumnValues)]...")

                    //  mySqlResultRow.
                    //  let sqlColumnResultValue = sqlResultRow.decode(column:sSqlResultRowColumnName)

                    }

                }

                let dictMySqlResultRow:[String:Any] = mySqlResultRow.toDictionary()

                self.xcgLogMsg("\(sCurrMethodDisp) Row #(\(cMySqlResultRows)) has a dictionary of #(\(dictMySqlResultRow.count)) Columns of data of [\(dictMySqlResultRow)]...")

                listMySQLResultRows.append(dictMySqlResultRow)
                
            }
            
        }
        catch
        {
            
            self.xcgLogMsg("\(sCurrMethodDisp) Called  'self.mySqlDatabaseManager.executeQuery(query:)' with a SQL 'test' statement 'self.sSqlSelectStatement' of [\(self.sSqlSelectStatement)] -  statement execution failed...")
            
        }

        self.listMySQLResultRows = listMySQLResultRows
        
        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - returned 'self.listMySQLResultRows' has #(\(self.listMySQLResultRows.count)) row(s) from a 'listMySQLResultRows' that has #(\(listMySQLResultRows.count)) row(s)...")

        return

    }   // End of private func executeMySqlTestStatement() async.
    
}   // End of struct AppMySqlDataView(View). 

@available(iOS 14.0, *)
#Preview
{
    
    AppMySqlDataView()
    
}

