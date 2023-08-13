//
//  GetAppView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 29/05/2023.
//

import SwiftUI

struct GetAppView: View {
    var test = "test"
    var body: some View {
        ZStack {
            Color.lightGreen.ignoresSafeArea()
            GeometryReader { reader in
                let width = reader.size.width
                let height: CGFloat = 300

                Path { path in
                    path.move(to: CGPoint(x: 0, y: reader.size.height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.addQuadCurve(to: CGPoint(x: width, y: height), control: CGPoint(x: width / 2, y: height - 100))
                    path.addLine(to: CGPoint(x: width, y: reader.size.height))
                }
                .fill(Color.mediumGreen)
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 30)
                Text("Don't miss our app")
                    .foregroundColor(Color.boldGreen)
                    .font(.system(size: 30, weight: .black))
                    .padding(.bottom, 3)
                Text("To track more of your rewards and earn more offers, download Taperk today!")
                    .foregroundColor(Color.mediumGreen)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                Spacer()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: 64)
                    Button {
                        // TODO: Handle open later
                    } label: {
                        Text("Later")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    Button {
                        // TODO: Handle open App Store
                    } label: {
                        Text("Download")
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

struct GetAppView_Previews: PreviewProvider {
    static var previews: some View {
        GetAppView()
    }
}
