//
//  SceneDelegate.swift
//  LordyalClip
//
//  Created by Chau Nguyen on 10/2/23.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var merchantID: String?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let urlContext = connectionOptions.urlContexts.first {
            guard let components = URLComponents(url: urlContext.url, resolvingAgainstBaseURL: true),
                  let queryItems = components.queryItems,
                  let id = queryItems.first(where: { $0.name == "store_id" })?.value
            else {
                merchantID = ""
                return
            }
            merchantID = String(id)
            print(merchantID!)
        }
        
        let contentView = ContentView(merchantID: merchantID)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
