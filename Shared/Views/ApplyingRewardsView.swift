//
//  ApplyingRewardsView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI 
import Combine

struct ApplyingRewardsView: View {

    private let twoColumnsLayout = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]

    @StateObject var viewModel: ApplyingRewardsViewModel = ApplyingRewardsViewModel()
    @ObservedObject var urlModel: InvocationURLModel
    @State private var isRedeemable = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("Select a reward\nto apply \(urlModel.points) point\(urlModel.points > 1 ? "s" : "")")
                            .font(.Title())
                            .foregroundColor(.boldGreen)
                            .font(.system(size: 30, weight: .black))
                            .multilineTextAlignment(.center)
                        LazyVGrid(columns: twoColumnsLayout, spacing: 20) {
                            ForEach(viewModel.items) { item in
                                ApplyingRewardItemView(model: item)
                                    .frame(height: 210)
                                    .onTapGesture {
                                        viewModel.selectItem(item)
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
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
                        Button {
                            // TODO: Handle open later
                        } label: {
                            Text("Later")
                        }
                        .buttonStyle(BackButton())
                        Spacer()
                        NavigationLink {
                            let selectedItem = viewModel.selectedItem
                            if let selectedItem = selectedItem?.toRewardModel() {
                                RedeemRewardView(model: selectedItem, urlModel: urlModel)
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            Text("Next")
                        }
                        .buttonStyle(RoundButton())
                        .disabled(!viewModel.redeemEnabled)
                        .simultaneousGesture(TapGesture().onEnded {
                            let selectedItem = viewModel.selectedItem
                            if selectedItem?.toRewardModel() != nil {
                                if (!selectedItem!.isClaimable) {
                                    selectedItem!.accumulatePoints(storeID: urlModel.storeID, orderID: urlModel.orderID, merchantID: urlModel.merchantID)
                                }
                            }
                        })
                    }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 20, trailing: 36))
                }
                if viewModel.isLoading {
                    ProgressView() {
                        Text("Getting rewards")
                            .font(.Body())
                    }
                }
            }
        }
        .onChange(of: urlModel.merchantID) { merchantID in
            viewModel.getList(merchantID: merchantID, points: urlModel.points)
        }
    }
}

struct ApplyingRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyingRewardsView(urlModel: InvocationURLModel())
    }
}
