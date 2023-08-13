//
//  BackButton.swift
//  Lordyal
//
//  Created by Chau Nguyen on 9/26/23.
//

import SwiftUI

struct BackButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack (spacing: 40) {
            Image(systemName: "chevron.backward")
                .font(.system(size: 22, weight: .semibold))
            configuration.label
                .font(.SemiBold(relativeTo: .body))
        }
        .foregroundColor(.boldGreen)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

