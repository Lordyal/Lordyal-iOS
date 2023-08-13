//
//  ApplyingRewardItemView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI

struct ApplyingRewardItemView: View {
    let model: ApplyingRewardItemModel
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                AsyncImage(url: URL(string: model.imageURL))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .cornerRadius(30.0)
                    .clipped()
            }
            LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(30)
            if model.selected {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.mediumGreen, lineWidth: 5)
            }
            VStack {
                HStack {
                    if model.selected {
                        Image("checked")
                    } else {
                        Image("unchecked")
                    }
                    Spacer()
                    HStack {
                        Image(model.isClaimable ? "claim" : "unclaim")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("\(model.collectedPoints)/\(model.totalPoint)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(model.isClaimable ? .white : .boldGreen)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background {
                        Rectangle()
                            .foregroundColor(model.isClaimable ? .yellow : .white)
                            .cornerRadius(25)
                    }
                }
                Spacer()
                Text(model.title)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .bold))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

struct ApplyingRewardItemView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyingRewardItemView(
            model: ApplyingRewardItemModel(
                rewardID: 1,
                selected: true,
                title: "Free normal size Spaghetti",
                imageURL: "",
                collectedPoints: 4,
                totalPoint: 6,
                convertRatio: 1/6
            )
        )
        ApplyingRewardItemView(
            model: ApplyingRewardItemModel(
                rewardID: 2,
                selected: true,
                title: "Free normal size Spaghetti",
                imageURL: "",
                collectedPoints: 6,
                totalPoint: 6,
                convertRatio: 1/6
            )
        )
    }
}
