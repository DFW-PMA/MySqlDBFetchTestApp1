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
    
    var body: some View
    {
        
        let _ = print("ContentView.View: Hello World!")
        
        VStack
        {
            
            Spacer()

            Text("")
                .font(.largeTitle)
            Text("")
                .font(.largeTitle)

        //  Image(systemName: "globe")
            Image(systemName: "pencil.tip.crop.circle.badge.arrow.forward")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Spacer()

            Divider()
                .background(Color.primary)

            Text("\(JmXcodeBuildSettings.jmAppDisplayName)")
                .bold()
            Text("")
            Text("Application Category:")
                .bold()
                .italic()
            Text("\(JmXcodeBuildSettings.jmAppCategory)")
            Text("")
            Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                .italic()
            Text("")
            Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                .italic()

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
