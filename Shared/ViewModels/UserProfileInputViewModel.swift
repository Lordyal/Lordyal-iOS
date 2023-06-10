//
//  UserProfileInputViewModel.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 09/06/2023.
//

import Foundation
import Combine

class UserProfileInputViewModel: ObservableObject {
    @Published var dateOfBirth: Date?
    @Published var phoneNumber: String = ""
    @Published var selectedGender: Gender? {
        didSet {
            isMaleSelected = selectedGender == .male
            isFemaleSelected = selectedGender == .female
            isOtherSelected = selectedGender == .other
        }
    }

    @Published var isMaleSelected: Bool = false
    @Published var isFemaleSelected: Bool = false
    @Published var isOtherSelected: Bool = false

    func selectGender(_ gender: Gender) {
        guard selectedGender != nil && gender == selectedGender else {
            selectedGender = gender
            return
        }

        selectedGender = nil
    }
}
