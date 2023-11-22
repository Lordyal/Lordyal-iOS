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
                Group {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.mediumGreen))
                        .frame(height: 100)
                    Group {
                        Rectangle()
                            .fill(Color(.lightGreen))
                            .frame(height: 33)
//                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 15, bottomLeading: 10, bottomTrailing: 10, topTrailing: 15))
//                            .fill(Color(.mediumGreen))
//                            .frame(height: 34)
                        RoundedRectangle(cornerRadius: 15)
                    }
                    .offset(y: -(100 - 32)/2)
                    Group {
                        Rectangle()
                            .fill(Color(.lightGreen))
                            .frame(height: 33)
//                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, bottomLeading: 15, bottomTrailing: 15, topTrailing: 10))
//                            .fill(Color(.mediumGreen))
//                            .frame(height: 34)
                        RoundedRectangle(cornerRadius: 15)
                    }
                    .offset(y: (100 - 32)/2)
                    Circle()
                        .fill(Color(.lightGreen))
                        .frame(width: 38)
                        .offset(x: -(width-80)/2)
                    Circle()
                        .fill(Color(.lightGreen))
                        .frame(width: 38)
                        .offset(x: (width-80)/2)
                }
                .frame(width: width - 80)
                
                HStack (spacing: 10) {
                    Spacer().frame(width: (width-80)/4 - 24)
                    AsyncImage(url: URL(string: model.imageURL))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 0.16*width, height: 0.16*width)
                        .cornerRadius(10)
                        .clipped()
                        .padding(.trailing, 5)
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
                        Text("Claimable")
                            .font(.Bold(size: 16))
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            .background(
                                Rectangle()
                                    .fill(Color(.mustard))
                                    .cornerRadius(22)
                            )
                    }
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .frame(width: (width-80)/2)
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
