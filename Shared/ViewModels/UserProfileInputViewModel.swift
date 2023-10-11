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
    
    func isFilled() -> Bool {
        return (dateOfBirth != nil) && !phoneNumber.isEmpty && (selectedGender != nil)
    }
    
    func toUserProfileModel() -> UserProfileModel? {
        if !isFilled() {
            return nil
        }
        
        let dateOfBirth = dateOfBirth!
        let selectedGender = selectedGender!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dob: String = formatter.string(from: dateOfBirth)
        
        let gender: String = selectedGender.label
        
        return UserProfileModel(dateOfBirth: dob, phoneNumber: phoneNumber, selectedGender: gender)
    }
}

struct UserProfileModel: Codable {
    let dateOfBirth: String
    let phoneNumber: String
    let selectedGender: String
    
    func saveUserProfile() {
        if UserDefaultsManager.userProfile == nil {
            UserDefaultsManager.userProfile = self
        }
    }
}
