//
//  MySqlDBFetchTestApp1App.swift
//  MySqlDBFetchTestApp1
//
//  Created by Daryl Cox on 04/24/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI

@main
struct MySqlDBFetchTestApp1App: App
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "MySqlDBFetchTestApp1App"
        static let sClsVers      = "v1.0301"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

    let sAppBundlePath:String    = Bundle.main.bundlePath

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

    var body: some Scene
    {
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) - 'sAppBundlePath' is [\(sAppBundlePath)]...")
        
        WindowGroup
        {
            
            ContentView()
            
        }

#if os(macOS)
        // This is the Window to diaplay the AppWorkRouteView...this works from MacOS...

        Window("AppMySqlData", id:"AppMySqlDataView")
        {

            AppMySqlDataView()

        }
#endif
        
    }
    
}   // End of @main struct MySqlDBFetchTestApp1App:App.

