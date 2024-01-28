//
//  ApplyingRewardItemView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI
import Kingfisher


struct ApplyingRewardItemView: View {
    let model: ApplyingRewardItemModel
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                KFImage(URL(string: model.imageURL))
                    .placeholder {ProgressView()}
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .cornerRadius(30.0)
                    .clipped()

                LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                    .cornerRadius(30)
                if model.selected {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(.mediumGreen), lineWidth: 5)
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
                                .font(.Bold(size: 12))
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
                        .font(.Bold(size: 12))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
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
                storeName: "Taperk's Kitchen",
                createdAt: "2023-06-24T21:11:47.283Z",
                endAt: "2023-07-01T03:38:11.000Z"
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
                storeName: "Taperk's Kitchen",
                createdAt: "2023-06-24T21:11:47.283Z",
                endAt: "2023-07-01T03:38:11.000Z"
            )
        )
    }
}
