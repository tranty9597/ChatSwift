//
//  AppDelegate.swift
//  ChatSwift
//
//  Created by Ty on 5/8/19.
//  Copyright © 2019 Ty. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
       
        
        FirebaseApp.configure()

        Messaging.messaging().delegate = self
         setupNotification(application)
        
        GIDSignIn.sharedInstance()?.clientID = "827450565160-o1016doaqjs1e2ct0o14f5rh5urhus5b.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    
    func setupNotification(_ application: UIApplication){
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        
        application.registerForRemoteNotifications()
        
    }
    
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
}

extension AppDelegate: MessagingDelegate {
    
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("fcmtoken", fcmToken)
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            //            let userId = user.userID                  // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            //            let fullName = user.profile.name
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            //            let email = user.profile.email
            // ...
            print(user)
        }
    }
}

