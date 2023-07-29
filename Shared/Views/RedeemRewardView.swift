//
//  RedeemRewardView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 04/06/2023.
//

import SwiftUI

struct RedeemRewardView: View {
    @State var model: RewardModel
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    backgroundView
                        .ignoresSafeArea()
                    VStack {
                        Spacer().frame(height: 20)

                        Text(model.isClaimable ? "Ready to redeem!" : "You're getting closer!")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)

                        HStack {
                            Image(model.isClaimable ? "claim" : "unclaim")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("\(model.points)/\(model.totalPoints)")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(model.isClaimable ? .white : .boldGreen)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background {
                            Rectangle()
                                .foregroundColor(model.isClaimable ? .yellow : .lightGreen)
                                .cornerRadius(48)
                        }

                        ZStack {
                            let width = proxy.size.width - 80
                            AsyncImage(url: URL(string: model.imageURL))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width, height: width)
                                .cornerRadius(48)
                                .clipped()
                            LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                                .cornerRadius(48)

                            if model.isClaimable {
                                VStack {
                                    Spacer()
                                    Text(model.storeName)
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                        .padding(.bottom, -10)
                                    Text(model.rewardDescription)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(.white)
                                    Spacer().frame(height: 20)
                                }
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)

                        Spacer()

                        if model.isClaimable {
                            VStack {
                                Text("Redeem now?")
                                    .foregroundColor(.boldGreen)
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.bottom, 2)
                                Text("Coupon will expire within 5 minutes of redemption time.")
                                    .foregroundColor(.mediumGreen)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            Text("Earn \(model.totalPoints - model.points) more point(s) to get this reward!")
                                .foregroundColor(.boldGreen)
                                .font(.system(size: 20, weight: .semibold))
                        }

                        Spacer()

                        if model.isClaimable {
                            HStack {
                                Spacer().frame(width: 40)
                                Button {
                                    // TODO: Handle open later
                                } label: {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(.boldGreen)
                                            .font(.system(size: 16, weight: .bold))
                                        Spacer().frame(width: 30)
                                        Text("Later")
                                            .foregroundColor(.boldGreen)
                                            .font(.system(size: 20, weight: .bold))
                                    }
                                }
                                Spacer()
                                NavigationLink {
                                    UserProfileInputView(viewModel: UserProfileInputViewModel())
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    Text("Redeem")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                        .padding(.horizontal, 32)
                                        .padding(.vertical, 12)
                                        .background {
                                            RoundedRectangle(cornerRadius: 48)
                                                .foregroundColor(.boldGreen)
                                        }
                                }
                            }
                            .padding()
                        } else {
                            Button {
                                // TODO: Handle open App Store
                            } label: {
                                HStack {
                                    Text("GET TAPERK APP")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
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
                            // TODO: Open see more reward
                        } label: {
                            VStack {
                                Text("See more rewards")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(.boldGreen.opacity(0.3))
                                    .padding(.bottom, 10)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.boldGreen.opacity(0.3))
                                    .padding(.bottom, 10)
                            }
                            .frame(maxWidth: .infinity)
                        }
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
                let height: CGFloat = 300

                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.addQuadCurve(to: CGPoint(x: width, y: height), control: CGPoint(x: width / 2, y: height + 100))
                    path.addLine(to: CGPoint(x: width, y: 0))
                }
                .fill(Color.mediumGreen)
            }
        }
    }
}

struct RewardModel {
    var points: Int
    var totalPoints: Int
    var storeName: String
    var rewardDescription: String
    var imageURL: String = ""

    var isClaimable: Bool {
        points == totalPoints
    }
}

struct RedeemRewardView_Previews: PreviewProvider {
    static var previews: some View {
        RedeemRewardView(
            model: RewardModel(
                points: 5,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti"
            )
        )
        RedeemRewardView(
            model: RewardModel(
                points: 6,
                totalPoints: 6,
                storeName: "Taperk's Kitchen",
                rewardDescription: "Free Normal Size Spaghetti"
            )
        )
    }
}
