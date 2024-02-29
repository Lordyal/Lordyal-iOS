//
//  AvailableRewardCardView.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/8/23.
//

import SwiftUI

struct AvailableRewardCardView: View {
    let model: ApplyingRewardItemModel
    private let width = UIScreen.main.bounds.width
    var body: some View {
        if model.isClaimable {
            ZStack {
                Image("award_bg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width - 20)
                HStack (spacing: 15) {
                    Spacer()
                    AsyncImage(url: URL(string: model.imageURL))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 0.16 * width, height: 0.16 * width)
                        .cornerRadius(10)
                        .clipped()
                        .padding(.trailing, 5)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 5, height: 26)
                        .cornerRadius(15)
                    VStack (alignment: .leading, spacing: 5) {
                        Text(model.storeName)
                            .font(.SemiBold(size: 16))
                            .frame(width: 150, alignment: .leading)
                        Text(model.title)
                            .font(.Bold(size: 16))
                            .frame(width: 150, alignment: .leading)
                        Text("Claimable")
                            .font(.Bold(size: 14))
                            .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                            .background(
                                Rectangle()
                                    .fill(Color(.mustard))
                                    .cornerRadius(22)
                            )
                    }
                    .foregroundColor(.white)
                    .lineLimit(1)

                    Spacer()
                }

            }
        }
    }
}

struct AvailableRewardCardView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableRewardCardView(
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
