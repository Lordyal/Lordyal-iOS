//
//  LordyalApp.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 29/05/2023.
//

import SwiftUI

@main
struct LordyalApp: App {
    var body: some Scene {
        WindowGroup {
            UserProfileInputView(viewModel: UserProfileInputViewModel())
        }
    }
}
