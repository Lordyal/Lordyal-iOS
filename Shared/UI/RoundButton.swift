//
//  RoundButton.swift
//  Lordyal
//
//  Created by Chau Nguyen on 9/26/23.
//

import SwiftUI

struct RoundButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150)
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
            .font(.Bold(size: 20))
            .background(Color(.boldGreen))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
