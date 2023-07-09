//
//  ApplyingRewardsView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI

struct ApplyingRewardsView: View {

    private let twoColumnsLayout = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]

    @ObservedObject var viewModel: ApplyingRewardsViewModel = ApplyingRewardsViewModel()

    var body: some View {
        NavigationView {
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
                            ForEach(viewModel.items) { item in
                                ApplyingRewardItemView(model: item)
                                    .frame(height: 210)
                                    .onTapGesture {
                                        viewModel.getList()
                                        viewModel.selectItem(item)
                                    }
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
                        NavigationLink {
                            if let selectedItem = viewModel.selectedItem?.toRewardModel() {
                                RedeemRewardView(model: selectedItem)
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            Text("Next")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.horizontal, 32)
                                .padding(.vertical, 12)
                                .background {
                                    RoundedRectangle(cornerRadius: 48)
                                        .foregroundColor(.boldGreen)
                                }
                        }
                        .disabled(!viewModel.redeemEnabled)
                        Spacer()
                            .frame(width: 32)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ApplyingRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyingRewardsView()
    }
}
