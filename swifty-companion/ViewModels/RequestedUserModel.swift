//
//  RequestedUserModel.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 13/09/2021.
//

import Foundation
import SwiftyJSON

class RequestedUserModel : ObservableObject
{
    @Published var requestUser = RequestedUser()
    
    var token           : String?
    var tokenStatus     : String?
    var requestStatus   : String?
    
    init()
    {
        self.getToken()
    }
    
    func getUser(_ name: String)
    {
        self.requestUser = RequestedUser()
        let url = URL(string: "\(Constants.userUrl)\(name)")
        let sem = DispatchSemaphore.init(value: 0)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = Constants.httpGet
        request.addValue("Bearer \(self.token ?? "")", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request)
        { data, response, error in
            
            defer{ sem.signal() }
            if (response != nil)
            {
                if let response = response as? HTTPURLResponse
                {
                    self.requestStatus = response.value(forHTTPHeaderField: "Status")
                    if (self.requestStatus != nil)
                    {
                        if (self.requestStatus!.contains(Constants.badToken))
                        {
                            self.getToken()
                        }
                    }
                }
            }
            if (error == nil && data != nil)
            {
                let json = JSON(data!)
                self.requestUser.id                 = json["id"].stringValue
                self.requestUser.login              = json["login"].stringValue
                self.requestUser.email              = json["email"].stringValue
                self.requestUser.phone              = json["phone"].stringValue
                self.requestUser.usualFullName    = json["usual_full_name"].stringValue
                self.requestUser.imageUrl          = json["image_url"].stringValue
                self.requestUser.staff              = json["staff"].boolValue
                self.requestUser.correctionPoints   = json["correction_point"].intValue
                self.requestUser.wallet             = json["wallet"].int
                self.requestUser.grade              = json["cursus_users"][0]["grade"].stringValue
                self.requestUser.level              = json["cursus_users"][0]["level"].doubleValue
                for (_, subJson) in json["projects_users"]
                {
                    if(!Constants.excludes.contains(subJson["project"]["name"].stringValue))
                    {
                        self.requestUser.projects.append(RequestedUser.Project(name: subJson["project"]["name"].stringValue,
                                                                               status: subJson["status"].stringValue,
                                                                               note: subJson["final_mark"].intValue,
                                                                               validated: subJson["validated?"].boolValue))
                    }
                }
            }
            dump(self)
        }
        dataTask.resume()
        sem.wait()
        self.requestUser.getImageData()
        self.requestUser.projects.sort {$0.name ?? "" < $1.name ?? ""}
        dump(self)
    }
    
    func getToken()
    {
        let url = URL(string: Constants.authUrl)
        if let url = url
        {
            var request = URLRequest(url: url)
            request.httpMethod = Constants.httpPost
            request.setValue(Constants.contentType, forHTTPHeaderField: "Content-Type")
            let parameters: [String:Any] = ["grant_type" : Constants.grantType,
                                            "client_id"  : Constants.apiKey,
                                            "client_secret" : Constants.apiSecret]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            let session = URLSession.shared
            session.dataTask(with: request)
            { data, response, error in
                if (error == nil && data != nil && response != nil)
                {
                    if let response = response as? HTTPURLResponse
                    {
                        self.tokenStatus =  response.value(forHTTPHeaderField: "Status")
                        do
                        {
                            let json = try JSON(data: data!)
                            self.token = json[Constants.tokenField].stringValue
                        }
                        catch
                        {
                            self.getToken()
                        }
                    }
                }
            }.resume()
        }
    }
}
