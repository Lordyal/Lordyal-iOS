//
//  ApplyingRewardsView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI 
import Combine
import UIKit


struct ApplyingRewardsView: View {
    private let twoColumnsLayout = Array(repeating: GridItem(.flexible(),spacing: 30), count: 2)
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var urlModel: InvocationURLModel
    @StateObject var viewModel: ApplyingRewardsViewModel = ApplyingRewardsViewModel()
    @State private var isRedeemable = false

    var body: some View {
        ZStack {
            Color.lightGreen.ignoresSafeArea()
            if authManager.isLoading {
                ProgressView() {
                    Text("Getting your information")
                        .font(.Body())
                        .foregroundColor(.boldGreen)
                }
                .tint(.boldGreen)
            } else {
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
                                LazyVGrid(columns: twoColumnsLayout) {
                                    ForEach(viewModel.items, id: \.self) { item in
                                        ApplyingRewardItemView(model: item)
                                            .frame(height: 210)
                                            .onTapGesture {
                                                print(item)
                                                viewModel.selectItem(item: item)
                                            }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            Spacer(minLength: 100)
                        }
                        VStack {
                            Spacer()
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [.clear, .lightGreen]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 150)
                            .allowsHitTesting(false)
                        }
                        .ignoresSafeArea()
                        
                        VStack {
                            Spacer()
                            HStack {
                                NavigationLink {
                                    GetAppView()
                                } label: {
                                    Text("Later")
                                }
                                .buttonStyle(BackButton())
                                Spacer()
                                NavigationLink {
                                    let selectedItem = viewModel.selectedItem
                                    if let selectedItem = selectedItem?.toRewardModel() {
                                        RedeemRewardView(model: selectedItem)
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
                                        selectedItem!.accumulatePoints(storeID: urlModel.storeID, orderID: urlModel.orderID, merchantID: urlModel.merchantID)
                                    }
                                })
                            }
                            .padding(EdgeInsets(top: 0, leading: 40, bottom: 20, trailing: 36))
                        }
                        if viewModel.isLoading {
                            ProgressView() {
                                Text("Getting rewards")
                                    .font(.Body())
                                    .foregroundColor(.boldGreen)
                            }
                            .tint(.boldGreen)
                        }
                    }
                }
                .onAppear() {
                    if let userID = UserDefaultsManager.userID, !userID.isEmpty, !urlModel.merchantID.isEmpty {
                        viewModel.getList(urlModel: urlModel)
                    }
                }
                .onChange(of: urlModel.merchantID) {_ in
                    viewModel.getList(urlModel: urlModel)
                }
            }
        }
    }
}
