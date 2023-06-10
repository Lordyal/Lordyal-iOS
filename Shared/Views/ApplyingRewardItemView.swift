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
            Color.orange
                .cornerRadius(30)
                .shadow(radius: 5)
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
                    }
                    Spacer()
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 24)
                        .cornerRadius(25)
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
                selected: true,
                title: "Free normal size Spaghetti",
                imageURL: "",
                collectedPoints: 4,
                totalPoint: 6
            )
        )
    }
}

struct ApplyingRewardItemModel: Identifiable {
    let id = UUID()
    var selected: Bool
    var title: String
    var imageURL: String
    var collectedPoints: Int
    var totalPoint: Int

    var selectedIconName: String {
        selected ? "checked" : "unchecked"
    }
}
