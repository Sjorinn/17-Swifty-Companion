//
//  Constants.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 13/09/2021.
//

import Foundation
import SwiftUI

struct Constants
{
    static var httpGet      = "GET"
    static var httpPost     = "POST"
    static var badToken     = "401"
    static var okStatus     = "200 OK"
    static var notModified  = "304 Not Modified"
    static var tokenField   = "access_token"
    static var contentType  = "application/json"
    static var grantType    = "client_credentials"
    static var apiKey       = "67d81429a4ee15b1b0cab88420fee1e2c125ccb6b9d803fdb594180c83618876"
    static var apiSecret    = "3a66768ce896d843f748d8be52fd297e21ea3de90153b2a1e164fd480a11afb8"
    static var authUrl      = "https://api.intra.42.fr/oauth/token"
    static var userUrl      = "https://api.intra.42.fr/v2/users/"
    static var notFound     = "User not found"
    static var tokenError   = "Error creating Token: "
    static var requestError = "Error sending request: "
    static var darkColor    = Color(red: 29/255, green: 35/255, blue: 35/255)
    static var lightColor   = Color(red: 153/255, green: 153/255, blue: 119/255)
    static var excludes     = ["00"
                               ,"01","02","03","04","05","06","07","08","09","10",
                               "11","12","13","14","15","16","17","18","19","20"
                               ,"21","22","23","24","25","26","27","28","29","30"]
    
}
