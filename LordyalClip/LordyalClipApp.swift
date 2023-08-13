//
//  App.swift
//  LordyalClip
//
//  Created by Nguyen Hoang Phuc on 29/05/2023.
//

import SwiftUI

@main
struct LordyalClipApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var merchantID: String = ""
    
    var body: some View {
        ApplyingRewardsView(merchantID: $merchantID)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        guard
            let incomingURL = userActivity.webpageURL,
            let components = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems,
            let id = queryItems.first(where: { $0.name == "store_id" })?.value
        else {
            return
        }
        merchantID = String(id)
        print(merchantID)
    }
}
