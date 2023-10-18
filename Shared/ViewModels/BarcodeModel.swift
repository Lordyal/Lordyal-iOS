//
//  BarCodeModel.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/13/23.
//

import Foundation

class BarcodeViewModel: ObservableObject {
    @Published var string: String = ""
    private var items: [BarcodeModel] = []
    
    func getBarcode(rewardID: Int) {
        Task {
            do {
                let url = URL.buildURL(
                    path: APIPath.rewardBarcode,
                    queries: ["reward_id": String(rewardID)]
                )

                let data: BarcodeDataModel = try await APIService.shared.get(url)
                items = data.data

                await MainActor.run {
//                    items.sort(by: {$0.id < $1.id})
                    items.forEach { item in
                        string += " \(item.content)"
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

struct BarcodeDataModel: Codable {
    let status: Int
    let data: [BarcodeModel]
}

struct BarcodeModel: Codable, Identifiable {
    let id: Int
    let content: String
    let isOneTimeUse: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case isOneTimeUse = "is_one_time_use"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.content = try container.decode(String.self, forKey: .content)
        self.isOneTimeUse = try container.decode(Bool.self, forKey: .isOneTimeUse)
    }
}
