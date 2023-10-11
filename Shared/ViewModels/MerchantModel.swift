//
//  MerchantModel.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/8/23.
//

import Foundation

struct MerchantModel: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "merchant_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

struct MerchantDataModel: Codable {
    let status: Int
    let data: [MerchantModel]
}

func getStoreName(merchantID: String, completion: @escaping (String?) -> Void) {
    Task {
        do {
            let url = URL.buildURL(
                path: APIPath.storeName,
                queries: ["id": merchantID]
            )

            let data: MerchantDataModel = try await APIService.shared.get(
                url
            )

            await MainActor.run {
                if let storeName = data.data.first?.name {
                    completion(storeName)
                } else {
                    completion(nil)
                }
            }
        } catch {
            print(error)
            completion(nil)
        }
    }
}
