//
//  ApplyingRewardsViewModel.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 18/06/2023.
//

import Foundation
import Combine

class ApplyingRewardsViewModel: ObservableObject {
    @Published var items: [ApplyingRewardItemModel] = ApplyingRewardsViewModel.data
    @Published var redeemEnabled: Bool = false
    var selectedItem: ApplyingRewardItemModel? {
        items.first { $0.selected }
    }

    func selectItem(_ item: ApplyingRewardItemModel) {
        items = items.map {
            if item.id == $0.id {
                return $0.toggle()
            }

            return $0.deselect()
        }
        redeemEnabled = selectedItem != nil
    }

    func getList() {
        Task {
            do {
                let url = URL.buildURL(
                    path: APIPath.availableRewards,
                    queries: ["user_id":"2", "merchant_id":"44"]
                )
                let data: AvailableRewardDataModel = try await APIService.shared.get(
                    url
                )
                print(data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: For testing purpose
extension ApplyingRewardsViewModel {
    static let data: [ApplyingRewardItemModel] = [
        ApplyingRewardItemModel(
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 6,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),
        ApplyingRewardItemModel(
            title: "Free normal size Spaghetti",
            imageURL: "",
            collectedPoints: 4,
            totalPoint: 6
        ),

    ]
}

struct ApplyingRewardItemModel: Identifiable {
    let rewardID = UUID()
    var selected: Bool = false
    var title: String
    var imageURL: String
    var collectedPoints: Int
    var totalPoint: Int
    var storeName: String = "Taperk's Kitchen"

    var id: String {
        rewardID.uuidString + "\(selected)"
    }

    var selectedIconName: String {
        selected ? "checked" : "unchecked"
    }

    var isClaimable: Bool {
        collectedPoints == totalPoint
    }

    func toRewardModel() -> RewardModel {
        RewardModel(
            points: collectedPoints,
            totalPoints: totalPoint,
            storeName: storeName,
            rewardDescription: title
        )
    }

    func toggle() -> Self {
        var result = self
        result.selected = !result.selected

        return result
    }

    func deselect() -> Self {
        var result = self
        result.selected = false

        return result
    }
}

struct AvailableRewardDataModel: Codable {
    let status: Int
    let data: [AvailableRewardItemDataModel]
}

struct AvailableRewardItemDataModel: Codable {
    let id: Int
    let code: String
    let name: String
    let bannerImageURLs: [String]
    let description: String
    let isActive: Bool
    let merchantId: Int
    let imageURL: String?
    let redeemPoints: Int
    let pointsAccumulated: Int

    enum CodingKeys: String, CodingKey {
        case id
        case code
        case name
        case bannerImageURLs = "banner_image_urls"
        case description
        case isActive = "is_active"
        case merchantId = "merchant_id"
        case imageURL = "image_url"
        case redeemPoints = "redeem_points"
        case pointsAccumulated = "points_accumulated"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.code = try container.decode(String.self, forKey: .code)
        self.name = try container.decode(String.self, forKey: .name)
        self.bannerImageURLs = try container.decode([String].self, forKey: .bannerImageURLs)
        self.description = try container.decode(String.self, forKey: .description)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.merchantId = try container.decode(Int.self, forKey: .merchantId)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.redeemPoints = try container.decodeIfPresent(Int.self, forKey: .redeemPoints) ?? 0
        self.pointsAccumulated = try container.decodeIfPresent(Int.self, forKey: .pointsAccumulated) ?? 0
    }
}
