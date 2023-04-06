//
//  RewardsTab.swift
//  Lordyal
//
//  Created by Sidney Sadel on 4/5/23.
//

import SwiftUI

struct RewardsTab: View {
    var body: some View {
        
        NavigationStack {
            List(sampleRewards) { reward in
                RewardCell(reward: reward)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Your Rewards")
        }
    }
}

struct RewardsTab_Previews: PreviewProvider {
    static var previews: some View {
        RewardsTab()
    }
}
