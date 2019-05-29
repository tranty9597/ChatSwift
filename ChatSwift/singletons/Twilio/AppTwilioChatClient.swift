//
//  TwilioAccessManager.swift
//  ChatSwift
//
//  Created by Ty on 5/26/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation
import TwilioAccessManager
import TwilioChatClient
import Alamofire

class AppTwilioChatClient{
    
    public static let shared = AppTwilioChatClient()
    
    var token: String = ""
    
    func fetchAccessToken(completion: @escaping (String) -> Void){
        let params: Parameters = ["platform": "ios", "identity": "54"]
        Api.shared.get(url: "/getToken", data: params) { (data) in
            print("twilio", data["token"])
            
            self.token = data["token"].rawString() ?? ""
            
            completion(self.token)
        }
        
    }
}
