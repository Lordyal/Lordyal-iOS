//
//  UserDefaultsManager.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/9/23.
//

import Foundation

struct UserDefaultsManager {
    static let suiteName = "group.lordyalapp.appClipMigration"
    private static let userDefaults: UserDefaults? = {
        return UserDefaults(suiteName: suiteName)
    }()
    
    static var shared: UserDefaults {
        guard let userDefaults = userDefaults else {
            fatalError("Unable to initialize UserDefaults with suitename: \(suiteName)")
        }
        return userDefaults
    }
    
    struct Keys {
        static let userID = "user_id"
        static let userProfile = "user_profile"
    }
    
    static var userID: String? {
        get {
            return shared.string(forKey: Keys.userID)
        }
        set {
            // TODO: make sure userID is unique (API?)
            shared.set(newValue, forKey: Keys.userID)
        }
    }

    static var userProfile: UserProfileModel? {
        get {
            if let userProfileData = shared.data(forKey: Keys.userProfile) {
                return try! JSONDecoder().decode(UserProfileModel.self, from: userProfileData)
            } else {
                return nil
            }
        }
        set {
            do {
                let newData = try JSONEncoder().encode(newValue)
                print(String(data: newData, encoding: .utf8)!)
                shared.set(newData, forKey: Keys.userProfile)
            } catch {
                print(error)
            }
        }
    }
}
