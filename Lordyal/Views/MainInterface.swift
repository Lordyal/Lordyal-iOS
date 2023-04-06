//
//  MainInterface.swift
//  Lordyal
//
//  Created by Sidney Sadel on 4/5/23.
//

import SwiftUI

struct MainInterface: View {
    var body: some View {
        
        TabView {
            RewardsTab()
                .tabItem {
                    Label("Rewards", systemImage: "takeoutbag.and.cup.and.straw.fill")
                }
                .tag(0)
            Text("")
                .tabItem {
                    Label("Explore", systemImage: "map.fill")
                }
                .tag(1)
            Text("")
                .tabItem {
                    Label("Profile", systemImage: "person.3.sequence.fill")
                }
                .tag(2)
        }
        
    }
}

struct MainInterface_Previews: PreviewProvider {
    static var previews: some View {
        MainInterface()
    }
}
