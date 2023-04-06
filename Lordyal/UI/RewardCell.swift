//
//  RewardCell.swift
//  Lordyal
//
//  Created by Sidney Sadel on 4/5/23.
//

import SwiftUI

struct RewardCell: View {
    
    var reward:RewardModel
    
    var body: some View {
        
        HStack {
            ImageView(url: reward.imgURL)
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(reward.merchantName)
                    .font(.headline.weight(.regular))
                Text(reward.discountDesc)
                    .font(.subheadline.weight(.regular))
                    .foregroundColor(.gray)
                Text("2 of 5")
                    .foregroundColor(.gray.opacity(0.75))
                    .font(.caption)
            }
            Spacer()
        }
        //.padding(.horizontal)
    }
}

struct RewardCell_Previews: PreviewProvider {
    static var previews: some View {
        RewardCell(reward: sampleRewards.first!)
    }
}
