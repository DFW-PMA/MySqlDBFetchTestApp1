//
//  ContentView.swift
//  MySqlDBFetchTestApp1
//
//  Created by Daryl Cox on 04/24/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ContentView"
        static let sClsVers      = "v1.0301"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openWindow)       var openWindow
    
           private  var bInternalTest:Bool             = false

    @State private  var cAppAboutButtonPresses:Int     = 0
    @State private  var cAppMySqlDataButtonPresses:Int = 0

    @State private  var isAppAboutViewModal:Bool       = false
    @State private  var isAppMySqlDataViewModal:Bool   = false

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
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):View.body: Executing...")
        
        VStack
        {

            Spacer()
            
            HStack(alignment:.center)
            {
      
                Button
                {
      
                    self.cAppAboutButtonPresses += 1
      
                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):Button(Xcode).'App About'.#(\(self.cAppAboutButtonPresses))...")
      
                    self.isAppAboutViewModal.toggle()
      
                }
                label:
                {
                    
                    VStack(alignment:.center)
                    {
                        
                        Label("", systemImage: "questionmark.diamond")
                            .help(Text("App About Information"))
                            .imageScale(.small)
                        
                        Text("About")
                            .font(.caption2)
                        
                    }
                    
                }
            #if os(macOS)
                .sheet(isPresented:$isAppAboutViewModal, content:
                    {
                        AppAboutView()
                    }
                )
            #endif
            #if os(iOS)
                .fullScreenCover(isPresented:$isAppAboutViewModal)
                {
                    AppAboutView()
                }
            #endif
            #if os(macOS)
                .buttonStyle(.borderedProminent)
                .padding()
            //  .background(???.isPressed ? .blue : .gray)
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            #endif
      
                Spacer()
      
                Button
                {
      
                    self.cAppMySqlDataButtonPresses += 1
      
                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):Button(Xcode).'App About'.#(\(self.cAppMySqlDataButtonPresses))...")
      
                    self.isAppMySqlDataViewModal.toggle()

                #if os(macOS)
                
                    // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                    openWindow(id:"AppMySqlDataView")
                
                #endif
      
                }
                label:
                {
                    
                    VStack(alignment:.center)
                    {
                        
                        Label("", systemImage: "swiftdata")
                            .help(Text("App MySql Data"))
                            .imageScale(.small)
                        
                        Text("MySql Data")
                            .font(.caption2)
                        
                    }
                    
                }
        //  #if os(macOS)
        //      .sheet(isPresented:$isAppMySqlDataViewModal, content:
        //          {
        //              AppMySqlDataView()
        //          }
        //      )
        //  #endif
            #if os(iOS)
                .fullScreenCover(isPresented:$isAppMySqlDataViewModal)
                {
                    AppMySqlDataView()
                }
            #endif
            #if os(macOS)
                .buttonStyle(.borderedProminent)
                .padding()
            //  .background(???.isPressed ? .blue : .gray)
                .cornerRadius(10)
                .foregroundColor(Color.primary)
            #endif
      
                Spacer()
      
            }
      
            Spacer()

            Text("")
                .font(.largeTitle)

            Image(systemName: "pencil.tip.crop.circle.badge.arrow.forward")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
        //  Spacer()

            Text("")
                .font(.largeTitle)

            Divider()
                .background(Color.primary)

            Text("")
                .font(.largeTitle)
            Text("")
                .font(.largeTitle)
            Text("\(JmXcodeBuildSettings.jmAppDisplayName)")
                .bold()
            Text("")
            Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                .italic()
            Text("")
                .font(.largeTitle)
            Text("")
                .font(.largeTitle)

            Divider()
                .background(Color.primary)

            Spacer()

        }
        .padding()
        
    }
    
}   // End of struct ContentView:View.

#Preview
{
    ContentView()
}
