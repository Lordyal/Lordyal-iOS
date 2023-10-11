//
//  ApplyingRewardsViewModel.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 18/06/2023.
//

import Foundation
import Combine

class ApplyingRewardsViewModel: ObservableObject {
    @Published var items: [ApplyingRewardItemModel] = []
    @Published var redeemEnabled: Bool = false
    @Published var isLoading: Bool = true

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

    func getList(merchantID: String, points: Int = 0) {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                let url = URL.buildURL(
                    path: APIPath.availableRewards,
                    queries: ["user_id": UserDefaultsManager.userID, "merchant_id": merchantID]
                )

                let data: AvailableRewardDataModel = try await APIService.shared.get(url)

                await MainActor.run {
                    items = data.data.map { $0.convertToItemModel(points: points) }
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserRewards(rewardID: Int, urlModel: InvocationURLModel) {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                let url = URL.buildURL(
                    path: APIPath.userRewards,
                    queries: ["user_id": UserDefaultsManager.userID]
                )
                
                let data: UserRewardDataModel = try await APIService.shared.get(url)
                
                await MainActor.run {
                    items = []
                    for item in data.data {
                        item.getReward(rewardID: rewardID, urlModel: urlModel) { reward in
                            if let reward = reward {
                                self.items.append(reward)
                            }
                        }
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

struct ApplyingRewardItemModel: Identifiable {
    let rewardID: Int
    var selected: Bool = false
    var title: String
    var imageURL: String
    var collectedPoints: Int
    var totalPoint: Int
    var storeName: String = "Taperk's Kitchen"

    var id: String {
        "\(rewardID)\(selected)"
    }

    var selectedIconName: String {
        selected ? "checked" : "unchecked"
    }

    var isClaimable: Bool {
        collectedPoints == totalPoint
    }

    func toRewardModel() -> RewardModel {
        RewardModel(
            id: rewardID, 
            points: collectedPoints,
            totalPoints: totalPoint,
            storeName: storeName,
            rewardDescription: title,
            imageURL: imageURL
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
    
    func accumulatePoints(storeID: String, orderID: String, merchantID: String) {
        Task {
            do {
                let url = URL.buildURL(
                    path: APIPath.rewardAccumulation
                )
                let params = "{\"reward_id\": \"\(rewardID)\", \"store_id\": \"\(storeID)\", \"order_id\": \"\(orderID)\", \"merchant_id\": \"\(merchantID)\", \"user_id\": \"\(UserDefaultsManager.userID!)\"}"
                let body = params.data(using: .utf8)
                print(String(data: body!, encoding: .utf8)!)

                let _: AvailableRewardItemDataModel = try await APIService.shared.post(
                    url,
                    body: body
                )

                await MainActor.run {
//                    items = data.data.map { $0.convertToItemModel() }
                }
            } catch {
                print(error)
            }
        }
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

    func convertToItemModel(points: Int = 0) -> ApplyingRewardItemModel {
        ApplyingRewardItemModel(
            rewardID: id,
            title: description,
            imageURL: imageURL ?? "",
            collectedPoints: pointsAccumulated + points,
            totalPoint: redeemPoints,
            storeName: name
        )
    }
}

struct UserRewardModel: Codable {
    let id: Int
    let merchantID: Int
    let storeID: Int
    let pointsAccumulated: Int
    let isRedeemed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "reward_id"
        case merchantID = "merchant_id"
        case storeID = "store_id"
        case pointsAccumulated = "points_accumulated"
        case isRedeemed = "is_redeemed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.merchantID = try container.decode(Int.self, forKey: .merchantID)
        self.storeID = try container.decode(Int.self, forKey: .storeID)
        self.pointsAccumulated = try container.decode(Int.self, forKey: .pointsAccumulated)
        self.isRedeemed = try container.decode(Bool.self, forKey: .isRedeemed)
    }
    
    func getReward(rewardID: Int, urlModel: InvocationURLModel, completion: @escaping (ApplyingRewardItemModel?) -> Void) {
//        if (id != rewardID && merchantID == Int(urlModel.merchantID) && storeID == Int(urlModel.storeID) && !isRedeemed) {
        if (merchantID == Int(urlModel.merchantID) && storeID == Int(urlModel.storeID) && !isRedeemed) {
            Task {
                do {
                    let url = URL.buildURL(
                        path: APIPath.reward,
                        queries: ["id": String(id)]
                    )

                    let data: AvailableRewardDataModel = try await APIService.shared.get(url)

                    await MainActor.run {
                        if let reward = data.data.first?.convertToItemModel(points: pointsAccumulated) {
                            completion(reward)
                        } else {
                            completion(nil)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
        completion(nil)
    }
}

struct UserRewardDataModel: Codable {
    let status: Int
    let data: [UserRewardModel]
}

struct RewardModel {
    var id: Int
    var points: Int
    var totalPoints: Int
    var storeName: String
    var rewardDescription: String
    var imageURL: String = ""

    var isClaimable: Bool {
        points == totalPoints
    }
    
    func redeemReward(merchantID: String, storeID: String) {
        Task {
            do {
                let url = URL.buildURL(
                    path: APIPath.redeemReward
                )
                
                let body: [String: Any] = ["user_id": UserDefaultsManager.userID!, "merchant_id": merchantID, "store_id": storeID, "reward_id": String(id)]
                let jsonData = try? JSONSerialization.data(withJSONObject: body)
                
                var headers = [String: String]()
                headers["Content-Type"] = "application/json"
                headers["Content-Length"] = String(describing: jsonData!.count)
                
                let _: AvailableRewardItemDataModel = try await APIService.shared.post(
                    url,
                    body: jsonData,
                    headers: headers
                )
                
                await MainActor.run {
                    
                }
                
            } catch {
                print(error)
            }
        }
    }
}
