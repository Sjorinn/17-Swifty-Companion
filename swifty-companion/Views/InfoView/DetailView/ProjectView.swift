//
//  ProjectView.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 15/09/2021.
//

import SwiftUI

struct ProjectView: View
{
    var projects : [RequestedUser.Project]
    
    var body: some View
    {
        ForEach(projects, id: \.self)
        {   project in
            ZStack
            {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 50, alignment: .leading)
                    .foregroundColor(.white)
                    .opacity(0.60)
                    .border(Constants.darkColor, width: 2)
                HStack
                {
                    Spacer()
                    Text(project.name!)
                    if(project.note != nil)
                    {
                        Text(project.status!)
                        if(project.status != "creating_group" && project.status != "in_progress")
                        {
                            Text(String(project.note!))
                                .foregroundColor(project.status == "Failed" ? .red : .green)                        }
                    }
                    Spacer()
                }.font(Font(UIFont(name: "Avenir", size: 15)!))
                .padding(.horizontal)
            }
        }
    }
}

