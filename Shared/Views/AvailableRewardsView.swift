//
//  AvailableRewardsView.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/8/23.
//

import SwiftUI

struct AvailableRewardsView: View {
    private let width = UIScreen.main.bounds.width
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ApplyingRewardsViewModel
    @ObservedObject var urlModel: InvocationURLModel 
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
                            .padding(.bottom, 5)
                        if isLoading {
                            ProgressView()
                        } else {
                            ForEach(viewModel.items) { item in
                                AvailableRewardCardView(model: item)
                                    .onTapGesture {
                                        presentationMode.wrappedValue.dismiss()
                                        reward = item.toRewardModel()
                                    }
                            }
                            .padding(.bottom, 2)
                            Text("Comeback to \(urlModel.storeName) to get more!")
                                .font(.SemiBold())
                                .foregroundColor(Color(.boldGreen))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: width - 80)
                                .padding(.top, 3)
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
            urlModel: InvocationURLModel(),
            reward: .constant(RewardModel(id: 1, points: 5, totalPoints: 10, storeName: "Starbucks", rewardDescription: "Caramel Machiato")),
            isLoading: .constant(true)
        )
    }
}
