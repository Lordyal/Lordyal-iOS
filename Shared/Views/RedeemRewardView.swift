//
//  RedeemRewardView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 04/06/2023.
//

import SwiftUI
import Kingfisher


struct RedeemRewardView: View {
    @EnvironmentObject var urlModel: InvocationURLModel
    @State var model: RewardModel
    @StateObject var userRewards: ApplyingRewardsViewModel = ApplyingRewardsViewModel()
    @State var showRewards = false

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    backgroundView
                        .ignoresSafeArea()
                    VStack {
                        Spacer().frame(height: 20)

                        Text(model.isClaimable ? "Ready to redeem!" : "You're getting closer!")
                            .font(.Title())
                            .foregroundColor(.white)

                        HStack {
                            if model.isClaimable {
                                Image("left_redeem")
                            }
                            HStack {
                                Image(model.isClaimable ? "claim" : "unclaim")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Spacer().frame(width: 12)
                                Text("\(model.points)/\(model.totalPoints)")
                                    .font(.ExtraBold())
                                    .foregroundColor(model.isClaimable ? .white : .boldGreen)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background {
                                Rectangle()
                                    .foregroundColor(model.isClaimable ? Color(.mustard) : .lightGreen)
                                    .cornerRadius(48)
                            }
                            if model.isClaimable {
                                Image("right_redeem")
                                    .offset(y: -25)
                            }
                        }

                        ZStack {
                            let constant = proxy.size.width - 80
                            KFImage(URL(string: model.imageURL))
                                .placeholder {ProgressView()}
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: constant, height: constant)
                                .cornerRadius(48)
                                .clipped()
                            LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                                .cornerRadius(48)

                            if model.isClaimable {
                                VStack {
                                    Spacer()
                                    Text(model.storeName)
                                        .lineLimit(1)
                                        .font(.SemiBold(size: 24))
                                        .foregroundColor(.white)
                                        .padding(.bottom, -10)
                                    Text(model.rewardDescription)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .font(.Bold(size: 30))
                                        .foregroundColor(.white)
                                    Spacer().frame(height: 20)
                                }
                                .padding(.horizontal, 5)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)

                        Spacer()

                        if model.isClaimable {
                            VStack (spacing: 4) {
                                Text("Redeem now?")
                                    .foregroundColor(.boldGreen)
                                    .font(.SemiBold(size: 20))
                                Text("Coupon will expire within **5 minutes**\nof redemption time.")
                                    .font(.Body(size: 16))
                                    .foregroundColor(.mediumGreen)
                            }
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                        } else {
                            Text("Earn \(model.totalPoints - model.points) more point\(model.totalPoints - model.points > 1 ? "s" : "") to get\nthis reward!")
                                .foregroundColor(.boldGreen)
                                .font(.SemiBold(size: 20))
                                .multilineTextAlignment(.center)
                        }

                        Spacer()

                        if model.isClaimable {
                            HStack {
                                NavigationLink {
                                    GetAppView()
                                } label: {
                                    Text("Later")
                                }
                                .buttonStyle(BackButton())
                                Spacer()
                                NavigationLink {
                                    if UserDefaultsManager.userProfile == nil {
                                        UserProfileInputView(
                                            viewModel: UserProfileInputViewModel(),
                                            rewardModel: model
                                        )
                                        .environmentObject(urlModel)
                                        
                                    } else {
                                        ScanBarCodeView(reward: model)
                                    }
                                } label: {
                                    Text("Redeem")
                                }
                                .navigationBarBackButtonHidden()
                                .buttonStyle(RoundButton())
                                .simultaneousGesture(TapGesture().onEnded {
                                    if UserDefaultsManager.userProfile != nil {
                                        model.redeemReward(merchantID: urlModel.merchantID, storeID: urlModel.storeID)
                                    }
                                })
                            }
                            .padding(EdgeInsets(top: 12, leading: 40, bottom: 12, trailing: 36))
                        } else {
                            NavigationLink {
                                GetAppView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Text("GET TAPERK APP")
                                        .foregroundColor(.white)
                                        .font(.Bold(size: 20))
                                        .padding(.vertical, 4)
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 16, weight: .bold))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .tint(.boldGreen)
                            .padding(.horizontal, 40)
                        }

                        Spacer()

                        Button {
                            showRewards.toggle()
                            if showRewards {
                                userRewards.getUserRewards(rewardID: model.id, urlModel: urlModel)
                            }
                        } label: {
                            VStack {
                                Text("See more rewards")
                                    .font(.Body())
                                    .foregroundColor(.boldGreen.opacity(0.3))
                                    .padding(.bottom, 10)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.boldGreen.opacity(0.3))
                                    .padding(.bottom, 10)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .sheet(isPresented: $showRewards, content: {
                            AvailableRewardsView(viewModel: userRewards, reward: $model, isLoading: $userRewards.isLoading)
                                .environmentObject(urlModel)
                                .presentationDetents([.medium, .large])
                                .presentationDragIndicator(.automatic)
                        })
                    }
                }
            }
        }
    }

    var backgroundView: some View {
        Group {
            Color.lightGreen.ignoresSafeArea()
            GeometryReader { reader in
                let width = reader.size.width
                let height: CGFloat = 315

                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.addQuadCurve(to: CGPoint(x: width, y: height), control: CGPoint(x: width / 2, y: height + 60))
                    path.addLine(to: CGPoint(x: width, y: 0))
                }
                .fill(Color(.mediumGreen))
            }
        }
    }
}

struct RedeemRewardView_Previews: PreviewProvider {
    static var previews: some View {
        RedeemRewardView(
            model: RewardModel(
                id: 1,
                points: 5,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti",
                createdAt: "2023-06-24T21:11:47.283Z",
                endAt: "2023-07-01T03:38:11.000Z"
            )
        )
        .environmentObject(InvocationURLModel.shared)
        RedeemRewardView(
            model: RewardModel(
                id: 2,
                points: 6,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti",
                createdAt: "2023-06-24T21:11:47.283Z",
                endAt: "2023-07-01T03:38:11.000Z"
            )
        )
        .environmentObject(InvocationURLModel.shared)
    }
}
