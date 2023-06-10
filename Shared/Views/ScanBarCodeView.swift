//
//  ScanBarCodeView.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 31/05/2023.
//

import SwiftUI

struct ScanBarCodeView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Text("Scan and enjoy!")
                .font(.system(size: 30, weight: .bold))
            Spacer()
            Rectangle()
                .frame(width: 300, height: 150)
            Text("9 54844 56 LORDYAL 2203 85300 773")
            Spacer()
            Text("Date created: April-18-2023 05:13:57 GMT+6")
                .font(.system(size: 16))
            Text("EXP: April-18-2023 05:18:57 GMT+6")
                .font(.system(size: 16))
                .padding(.bottom, 16)
            Button {
                // TODO: Handle dismiss
            } label: {
                Text("Dismiss")
                    .font(.system(size: 20, weight: .bold))
                    .underline()
                    .foregroundColor(.black)
            }

        }
    }
}

struct ScanBarCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScanBarCodeView()
    }
}
