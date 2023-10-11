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
        ZStack {
            Group {
                Rectangle()
                    .fill(Color(.mediumGreen))
                    .frame(width: width - 80, height: 100)
                    .cornerRadius(15)
                Circle()
                    .fill(Color.lightGreen)
                    .frame(width: 0.1*width)
                    .offset(x: -(width-80)/2)
                Circle()
                    .fill(Color.lightGreen)
                    .frame(width: 0.1*width)
                    .offset(x: (width-80)/2)
            }
            
            HStack (spacing: 15) {
                Spacer().frame(width: (width-80)/4 - 28)
                AsyncImage(url: URL(string: model.imageURL))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 0.15*width, height: 0.15*width)
                    .cornerRadius(10)
                    .clipped()
                Rectangle()
                    .fill(.white)
                    .frame(width: 5, height: 26)
                    .cornerRadius(15)
                VStack (alignment: .leading) {
                    Text(model.storeName)
                        .font(.SemiBold(size: 16))
                    Text(model.title)
                        .font(.Bold(size: 16))
                    Spacer().frame(height: 2)
                    if model.isClaimable {
                        Text("Claimable")
                            .font(.Bold(size: 16))
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            .background(
                                Rectangle()
                                    .fill(Color(.mustard))
                                    .cornerRadius(22)
                            )
                    }
                }
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(width: (width-80)/2)
                Spacer()
            }
        }
    }
}

struct AvailableRewardCardView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableRewardCardView(
            model: ApplyingRewardItemModel(
                rewardID: 1,
                selected: true,
                title: "Free normal size Spaghetti",
                imageURL: "",
                collectedPoints: 5,
                totalPoint: 6
            )
        )
        AvailableRewardCardView(
            model: ApplyingRewardItemModel(
                rewardID: 2,
                selected: true,
                title: "Free normal size Spaghetti",
                imageURL: "",
                collectedPoints: 6,
                totalPoint: 6
            )
        )
    }
}
