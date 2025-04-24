//
//  AppDetailsView.swift
//  RevenueCatSwiftUIDemoApp1App
//
//  Created by Daryl Cox on 04/22/2025 - v1.0102.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI

struct AppDetailsView: View
{
    
    var body: some View
    {
        
        let _ = print("AppDetailsView.View: Hello World!")
        
        VStack
        {

        //  Spacer()
        //  
        //  Text("")
        //      .font(.largeTitle)
        //  Text("")
        //      .font(.largeTitle)

            Image(systemName: "pencil.tip.crop.circle.badge.arrow.forward")
                .imageScale(.medium)
                .foregroundStyle(.tint)
            
        //  Spacer()

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

        //  Spacer()
            
        }
        .padding()
        
    }
    
}   // End of struct AppDetailsView:View.

#Preview
{

    AppDetailsView()

}

