//
//  User.swift
//  swifty-companion
//
//  Created by Pierre Chambon on 11/09/2021.
//

import Foundation

class RequestedUser: Identifiable, ObservableObject, Decodable
{
    
    var imageData           : Data?
    var imageUrl            : String?
    
    var id                  : String?
    var login               : String?
    var usualFullName       : String?
    var email               : String?
    var phone               : String?
    var level               : Double?
    var grade               : String?
    var correctionPoints    : Int?
    var wallet              : Int?
    var projects            = [Project]()
    var staff               : Bool?
    
    struct Project: Decodable, Hashable
    {
        var name            : String?
        var status          : String?
        var note            : Int?
        var validated       : Bool?
    }
    
    func getImageData()
    {
        guard imageUrl != nil else
        {
            return
        }
        
        if let url = URL(string: imageUrl!)
        {
            let session = URLSession.shared
            let _ = session.dataTask(with: url)
            {   (data, response, error) in
                
                if (error == nil)
                {
                    DispatchQueue.main.async
                    {
                        self.imageData = data!
                    }
                }
                
            }.resume()
        }
    }
}
