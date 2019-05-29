//
//  User.swift
//  ChatSwift
//
//  Created by Ty on 5/15/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import Foundation

class User {
    public static let shared: User =  User();
    
    var getProfileStatus = FetchStatus.initital
    public var profile: UserProfile = UserProfile();
    
    func getProfile(completion: @escaping (UserProfile) -> Void) -> Void {
        getProfileStatus = FetchStatus.fetching
        Api.shared.get(url: ApiUrls.User.getProfile) { (json) in
            self.getProfileStatus = FetchStatus.success;
            completion(self.profile)    
        }
    }
}

