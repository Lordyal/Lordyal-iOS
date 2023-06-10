//
//  ApplyingRewardsView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI

struct ApplyingRewardsView: View {
    private let twoColumnsLayout = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    var body: some View {
        ZStack {
            Color.lightGreen
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Select a reward\nto apply 3 points")
                        .foregroundColor(.boldGreen)
                        .font(.system(size: 30, weight: .black))
                        .multilineTextAlignment(.center)
                    LazyVGrid(columns: twoColumnsLayout, spacing: 20) {
                        ForEach(Self.data) { item in
                            ApplyingRewardItemView(model: item)
                                .frame(height: 210)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }

            VStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(
                        colors: [.clear, .lightGreen]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 300)
                .allowsHitTesting(false)
            }
            .ignoresSafeArea()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: 64)
                    Button {
                        // TODO: Handle open later
                    } label: {
                        Text("Later")
                            .foregroundColor(.boldGreen)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    Button {
                        // TODO: Handle open App Store
                    } label: {
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(.boldGreen)
                    Spacer()
                        .frame(width: 32)
                }
                .padding()
            }
        }
    }
}

extension ApplyingRewardsView {
    static let data: [ApplyingRewardItemModel] = [
        ApplyingRewardItemModel(
            selected: true,
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            selected: false,
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            selected: true,
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            selected: true,
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            selected: true,
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),

    ]
}

struct ApplyingRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyingRewardsView()
    }
}
