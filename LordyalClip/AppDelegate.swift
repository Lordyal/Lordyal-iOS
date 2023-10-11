//
//  AppDelegate.swift
//  LordyalClip
//
//  Created by Chau Nguyen on 10/2/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaultsManager.shared.set("218", forKey: UserDefaultsManager.Keys.userID) // for testing
        
        if UserDefaultsManager.userID == nil {
            UserDefaultsManager.userID = UUID().uuidString // change this to conform with BE
        }
        print("UserID: \(UserDefaultsManager.userID!)")

        if let userProfile = UserDefaultsManager.userProfile {
            print(userProfile)
        } else {
            print("No user profile")
        }
        return true
    }
}
