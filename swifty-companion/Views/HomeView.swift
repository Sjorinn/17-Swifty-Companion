//
//  ContentView.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 11/09/2021.
//

import SwiftUI

struct HomeView: View
{
    @EnvironmentObject var model    : RequestedUserModel
    @State private var login        : String = ""
    @State private var errorText    : String = ""
    @State private var showAlert    : Bool   = false
    @State private var showInfo     : Bool   = false
    
    var body: some View
    {
        ZStack
        {
            Image("LoginBackground").resizable().scaledToFill().ignoresSafeArea()
            VStack
            {
                TextField("login", text: $login)
                    .font(Font(UIFont(name: "Avenir", size: 25)!))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width/1.6, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .opacity(0.75)
                    .border(Constants.darkColor, width: 2)
                    .padding(.bottom)
                    .autocapitalization(.none)
                Button
                {
                    model.getUser(login.lowercased())
                    if (model.requestStatus != Constants.okStatus && model.requestStatus != Constants.notModified)
                    {
                        showAlert = true
                        errorText = Constants.requestError + (model.requestStatus ?? "")
                    }
                    else if (model.tokenStatus != Constants.okStatus)
                    {
                        showAlert = true
                        errorText = Constants.tokenError + (model.tokenStatus ?? "")
                        
                    }
                    else if (model.requestUser.login == "")
                    {
                        showAlert = true
                        errorText = Constants.notFound
                    }
                    else
                    {
                        showInfo = true
                    }
                } label:
                {
                    ZStack
                    {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width/3, height: 50, alignment: .center)
                            .cornerRadius(20)
                            .foregroundColor(Constants.darkColor)
                        Text("Search").accentColor(Constants.lightColor)
                    }
                }.padding(.top)
                .sheet(isPresented: $showInfo, content:
                    {
                        InfoView()
                    })
                .alert(isPresented: $showAlert)
                {
                    Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
