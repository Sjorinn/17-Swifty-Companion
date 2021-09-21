//
//  UserDetailVIew.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 16/09/2021.
//

import SwiftUI

struct UserDetailView: View
{
    @EnvironmentObject var model : RequestedUserModel
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                .foregroundColor(.white)
                .opacity(0.5)
                .border(Constants.darkColor, width: 2)
                .padding(.top)
            VStack
            {
                let uiImage = UIImage(data: model.requestUser.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(100)
                    .padding(.top)
                Text("Login: \(model.requestUser.login ?? "")")
                    .accentColor((model.requestUser.staff ?? false) == true ? .blue : .black)
                    .font(Font(UIFont(name: "Avenir", size: 15)!))
                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("Level: \(String(format: "%.3f", model.requestUser.level ?? 0))")
                        Text("Full Name: \(model.requestUser.usualFullName ?? "")")
                        Text("Correction Points: \(model.requestUser.correctionPoints ?? 0)")
                    }
                    VStack(alignment: .leading)
                    {
                        Text("Phone number: \(model.requestUser.phone ?? "")")
                        Text("Grade: \(model.requestUser.grade ?? "")")
                        Text("Wallet: \(model.requestUser.wallet ?? 0)")
                    }
                
                }.font(Font(UIFont(name: "Avenir", size: 12)!))
            }
        }
    }
}
