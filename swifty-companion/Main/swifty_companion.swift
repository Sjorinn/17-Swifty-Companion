//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 11/09/2021.
//

import SwiftUI

@main
struct swifty_companion: App
{
    var body: some Scene
    {
        WindowGroup
        {
            HomeView().environmentObject(RequestedUserModel())
        }
    }
}
