//
//  AuthModel.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/14/23.
//

import Foundation
import UIKit

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    private let deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    @Published var isLoading: Bool = false
    
    private init() {}
    
    func initApp() {
        if UserDefaultsManager.userID == nil {
            Task {
                signUp() { id in
                    UserDefaultsManager.userID = id
                    print("New userID: \(UserDefaultsManager.userID ?? "")")
                }
            }
        }
    }
    
    func auth(username: String, password: String, completion: @escaping (String?) -> Void) {
        Task {
            do {
                let url = URL.buildURL(path: APIPath.auth)
                let body: [String: Any] = ["username": username, "password": password]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)


                let data: AuthDataModel = try await APIService.shared.post(
                    url,
                    body: jsonData
                )

                await MainActor.run {
                    completion(data.loginToken)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func signUp(completion: @escaping (String?) -> Void) {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                let url = URL.buildURL(path: APIPath.signUp)
                /* TESTING */
//                let body: [String: Any] = ["device_id": "test2", "username": "test2", "password": "Abcd1234", "is_customer": true, "roles": ["OWNER"]]
                let body: [String: Any] = ["device_id": self.deviceID, "username": self.deviceID, "password": "Abcd1234", "is_customer": true, "roles": ["OWNER"]]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)

                let data: AuthDataModel = try await APIService.shared.post(
                    url,
                    body: jsonData
                )
                
                await MainActor.run {
                    if let userID = data.data.first?.id {
                        completion(String(userID))
                    } else {
                        completion(nil)
                    }
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

struct AuthDataModel: Codable {
    let status: Int
    let data: [UserProfileItemModel]
    let loginToken: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(Int.self, forKey: .status)
        self.data = try container.decodeIfPresent([UserProfileItemModel].self, forKey: .data) ?? []
        self.loginToken = try container.decodeIfPresent(String.self, forKey: .loginToken) ?? ""
    }
}

