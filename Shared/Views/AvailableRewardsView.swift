//
//  AvailableRewardsView.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/8/23.
//

import SwiftUI

struct AvailableRewardsView: View {
    private let width = UIScreen.main.bounds.width
    @EnvironmentObject var urlModel: InvocationURLModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ApplyingRewardsViewModel
    @Binding var reward: RewardModel 
    @Binding var isLoading: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Spacer().frame(height: 30)
                        Text("Your Rewards")
                            .font(.Bold())
                            .foregroundColor(.boldGreen)
                            .frame(maxWidth: width - 80, alignment: .leading)
                            .padding(.bottom, 30)
                        if isLoading {
                            ProgressView()
                                .tint(.boldGreen)
                        } else {
                                ForEach(viewModel.items) { item in
                                    AvailableRewardCardView(model: item)
                                        .onTapGesture {
                                            presentationMode.wrappedValue.dismiss()
                                            reward = item.toRewardModel()
                                        }
                                        .frame(height: 100)
                                }
                                .padding(.bottom, 5)

                            Text("Comeback to \(urlModel.storeName) to get more rewards!")
                                .font(.SemiBold())
                                .foregroundColor(.boldGreen)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: width - 80)
                                .padding(.top, 30)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct AvailableRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableRewardsView(
            viewModel: ApplyingRewardsViewModel(),
            reward: .constant(RewardModel(
                id: 1,
                points: 5,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti",
                createdAt: "2023-06-24T21:11:47.283Z",
                endAt: "2023-07-01T03:38:11.000Z"
            )),
            isLoading: .constant(true)
        )
        .environmentObject(InvocationURLModel.shared)
    }
}
