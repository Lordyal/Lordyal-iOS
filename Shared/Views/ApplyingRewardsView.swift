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
    
    @Binding var merchantID: String

    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("Select a reward\nto apply 3 points")
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
                            if let selectedItem = viewModel.selectedItem?.toRewardModel() {
                                RedeemRewardView(model: selectedItem)
                                    .navigationBarBackButtonHidden()
                            }
                        } label: {
                            Text("Next")
                        }
                        .buttonStyle(RoundButton())
                        .disabled(!viewModel.redeemEnabled)
                    }
                    .padding(EdgeInsets(top: 0, leading: 50, bottom: 20, trailing: 50))
                }
            }
        }
        .onAppear {
            print("Merchant ID (ApplyingView): \(merchantID)")
            viewModel.getList(merchantID: merchantID)
        }
        .onChange(of: merchantID) { merchantID in
            viewModel.getList(merchantID: merchantID)
        }
    }
}

struct ApplyingRewardsView_Previews: PreviewProvider {
    @State static var merchant_id: String = "44"
    static var previews: some View {
        ApplyingRewardsView(merchantID: $merchant_id)
    }
}
