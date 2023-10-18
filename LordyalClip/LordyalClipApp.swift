//
//  App.swift
//  LordyalClip
//
//  Created by Nguyen Hoang Phuc on 29/05/2023.
//

import SwiftUI

@main
struct LordyalClipApp: App {
    init() {
        /* FOR TESTING */
//        UserDefaultsManager.userID = nil 
        UserDefaultsManager.shared.set("317", forKey: UserDefaultsManager.Keys.userID)
        UserDefaultsManager.userProfile = nil
        
        AuthManager.shared.initApp()
    }
    
    @StateObject var urlModel: InvocationURLModel = InvocationURLModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(urlModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var urlModel: InvocationURLModel
    
    var body: some View {
        ApplyingRewardsView()
            .environmentObject(AuthManager.shared)
            .environmentObject(urlModel)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard
            let incomingURL = userActivity.webpageURL,
            let components = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems,
            let order_id = queryItems.first(where: { $0.name == "order_id" })?.value,
            let store_id = queryItems.first(where: { $0.name == "store_id" })?.value,
            let merchant_id = queryItems.first(where: { $0.name == "merchant_id" })?.value,
            let token = queryItems.first(where: { $0.name == "token" })?.value,
            let points = queryItems.first(where: { $0.name == "points" })?.value
        else {
            return
        }
        urlModel.orderID = order_id
        urlModel.storeID = store_id
        urlModel.merchantID = merchant_id
        urlModel.token = token
        urlModel.points = Int(points)!
        getStoreName(merchantID: merchant_id) { name in
            urlModel.storeName = name ?? ""
        }
        AuthManager.shared.auth(username: "duy", password: "123456") { token in
            urlModel.loginToken = token ?? ""
        }
    }
}

