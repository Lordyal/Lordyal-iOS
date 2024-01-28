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

        let gender: String = selectedGender.label.uppercased()

        return UserProfileModel(dateOfBirth: dob, phoneNumber: phoneNumber, selectedGender: gender)
    }
}

struct UserProfileDataModel: Codable {
    let status: Int
    let data: [UserProfileItemModel]
}

struct UserProfileItemModel: Codable {
    let id: Int
    let dateOfBirth: String
    let phoneNumber: String
    let selectedGender: String

    enum CodingKeys: String, CodingKey {
        case id
        case dateOfBirth
        case phoneNumber = "phone_number"
        case selectedGender = "gender"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth) ?? ""
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        self.selectedGender = try container.decodeIfPresent(String.self, forKey: .selectedGender) ?? ""
    }
}

struct UserProfileModel: Codable {
    let dateOfBirth: String
    let phoneNumber: String
    let selectedGender: String

    func saveUserProfile(loginToken: String) {
        if UserDefaultsManager.userProfile == nil {
            UserDefaultsManager.userProfile = self
        }

        Task {
            do {
                let url = URL.buildURL(
                    path: APIPath.userInfo
                )
                // TODO: missing DOB
                let body: [String: Any] = ["id": UserDefaultsManager.userID!, "gender": selectedGender, "phone_number": phoneNumber]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)

                let _: UserProfileDataModel = try await APIService.shared.post(
                    url,
                    body: jsonData,
                    method: "PUT",
                    token: loginToken
                )

                await MainActor.run {

                }
            } catch {
                print(error)
            }
        }
    }
}
