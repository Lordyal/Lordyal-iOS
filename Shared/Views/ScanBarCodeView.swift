//
//  ScanBarCodeView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI

struct ScanBarCodeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 50)
                Text("Scan and enjoy!")
                    .font(.Title())
                Spacer()
                Rectangle()
                    .frame(width: 300, height: 150)
                Text("9 54844 56 LORDYAL 2203 85300 773")
                    .font(.Body())
                Spacer()
                Text("Date created: April-18-2023 05:13:57 GMT+6")
                    .font(.Body())
                Text("EXP: April-18-2023 05:18:57 GMT+6")
                    .font(.Body())
                    .padding(.bottom, 30)
                NavigationLink {
                    GetAppView()
                } label: {
                    VStack {
                        Text("Dismiss")
                            .font(.Bold(size: 20))
                            .padding(.bottom, -8)
                        Rectangle()
                            .frame(width: 78, height: 2)
                    }
                    .foregroundColor(.black)
                }
                Spacer()
                    .frame(height: 50)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ScanBarCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanBarCodeView()
    }
}
