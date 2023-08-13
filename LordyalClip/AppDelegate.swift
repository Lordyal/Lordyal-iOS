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
        
        guard let sharedUserDefaults = UserDefaults(suiteName: "group.lordyalapp.appClipMigration") else {
            return true
        }
        
        sharedUserDefaults.set("2", forKey: "user_id")
        if sharedUserDefaults.string(forKey: "user_id") == nil {
            sharedUserDefaults.set(UUID().uuidString, forKey: "user_id")
        }

        print(String(sharedUserDefaults.string(forKey: "user_id")!))
        return true
    }
}
