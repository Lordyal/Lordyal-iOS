//
//  LordyalApp.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 29/05/2023.
//

import SwiftUI

@main
struct LordyalApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @StateObject var urlModel: InvocationURLModel = InvocationURLModel.shared
    var body: some Scene {
        WindowGroup {
            ApplyingRewardsView().environmentObject(urlModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let sharedUserDefaults = UserDefaults(suiteName: "group.lordyalapp.appClipMigration"),
            let user_id = sharedUserDefaults.string(forKey: "user_id")
        else {
            return true
        }

        print("User id \(user_id)")
        return true
    }
    
}
