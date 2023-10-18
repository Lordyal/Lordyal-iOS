//
//  GetAppView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 29/05/2023.
//

import SwiftUI
import StoreKit

struct GetAppView: View {
    @State private var showDownloadLink = false
    var body: some View {
        ZStack {
            Color.lightGreen.ignoresSafeArea()
            GeometryReader { reader in
                let width = reader.size.width
                let height: CGFloat = 300
                Path { path in
                    path.move(to: CGPoint(x: 0, y: reader.size.height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.addQuadCurve(to: CGPoint(x: width, y: height), control: CGPoint(x: width / 2, y: height - 60))
                    path.addLine(to: CGPoint(x: width, y: reader.size.height))
                }
                .fill(Color(.mediumGreen))
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 40)
                Text("Don't miss our app!")
                    .foregroundColor(.boldGreen)
                    .font(.Title())
                    .padding(.bottom, 4)
                Text("To track more of your rewards and earn more offers, download Taperk today!")
                    .foregroundColor(.mediumGreen)
                    .font(.Body())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                Spacer()
                    .frame(height: 24)
                HStack {
                    Spacer()
                        .frame(width: 64)
                    Button {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        }
                    } label: {
                        Text("Later")
                            .foregroundColor(.white)
                            .font(.SemiBold())
                    }
                    Spacer()
                    Button {
                        showDownloadLink.toggle()
                    } label: {
                        Text("Download")
                    }
                    .buttonStyle(RoundButton())
                    Spacer()
                        .frame(width: 32)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .appStoreOverlay(isPresented: $showDownloadLink) {
            // TODO: check Apple's identifier
            SKOverlay.AppConfiguration(appIdentifier: "YPN388FR66", position: .bottom)
        }
    }
}

struct GetAppView_Previews: PreviewProvider {
    static var previews: some View {
        GetAppView()
    }
}
