//
//  InfoView.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 15/09/2021.
//

import SwiftUI

struct InfoView: View
{
    @EnvironmentObject var model : RequestedUserModel
    
    var body: some View
    {
        ZStack
        {
            Image("UserBackground").resizable().scaledToFill().ignoresSafeArea()
            VStack
            {
                UserDetailView()
                HStack
                {
                    ScrollView
                    {
                            ProjectView(projects: model.requestUser.projects)
                    }
                }
            }
        }
    }
}
