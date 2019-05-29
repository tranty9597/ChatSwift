//
//  Api.swift
//  ChatSwift
//
//  Created by Ty on 5/12/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class Api  {
    
    public static let shared: Api = Api()   
    
    let BASE_URL: String = "https://quanca-ms.tranty9597.now.sh/api"
    
    func validateRequest(request: URLRequest?, response: HTTPURLResponse?, data: Any?) -> Request.ValidationResult {
        if response?.statusCode == 200 {
            return .success
        }else {
            return Request.ValidationResult.failure(NSError())
        }
    }
    
    func post(url: String, data: Parameters, config: Any = "", completionHandle: @escaping (JSON) -> Void ) -> Void {
        
        Alamofire.request("\(self.BASE_URL)", method: .post, parameters: data, encoding: JSONEncoding.default)
            .validate(self.validateRequest)
            .responseJSON { (response) in
                completionHandle(JSON.init(data: response.data!))
        }
        
    }
    
    func get(url: String, data: Any = "", config: Any = "", completionHandle: @escaping (JSON) -> Void ) -> Void {
        let parameters: Parameters = [:]
        
        Alamofire.request("\(self.BASE_URL)\(url)", method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .validate(self.validateRequest)
            .responseJSON { (response) in
                completionHandle(JSON(data: response.data!)["data"])
        }
    }
}
