//
//  AccumulationRewardsViewModel.swift
//  Lordyal
//
//  Created by Michael Ha on 9/3/23.
//

import Foundation
import Combine


/*
 "_id": "64d5c16d77edefb4fcba5385",
 "user_id": 29,
 "merchant_id": 32,
 "store_id": 4,
 "reward_id": 45,
 "is_redeemed": false,
 "points_accumulated": 5,
 "redeem_date": null,
 "created_at": "2023-08-11T05:04:47.475Z",
 "updated_at": "2023-08-11T05:04:45.998Z",
 "id": 18,
 "status": "",
 "__v": 0
 */

class AccumulatingRewardViewModel: ObservableObject{
    @Published var items: [AccumulationRewardItemModel] = []
    @Published var accumulatEnable: Bool = false
    
    
    
    func postList(){
        Task{
            do{
                let url = URL.buildURL(path: APIPath.rewardAccumulation)
            }
        }
    }
    
}

struct AccumulationModel{
    var userID: Int
    var totalPoint: Int
    var merchantID: Int
    var redeem: Bool
    var storeID: Int
}
struct AccumulationRewardItemModel: Identifiable {

    
    var userID: Int
    var merchantID: Int
    var storeID: Int
    var point:Int
    var redeem: Bool = false
    
    
    func toAccumulationModel() -> AccumulationModel{
        AccumulationModel(userID: userID, totalPoint: point, merchantID: merchantID, redeem: redeem, storeID: storeID)
    }
    
    
    func toggle() -> Self{
        var result = self
        result.redeem = !result.redeem
        
        return result
    }
}


// TODO: Create Model (hasn't done)
struct AccumulationRewardItemDataModel: Codable {
    let id: Int
    let userId: Int
    let merchantId: Int
    let storeId: Int
    let rewardId: Int
    let isRedeemed: Bool
    let pointsAccumulated: Int
//    let redeemDate: Any?
    let createdAt: String
    let updatedAt: String


    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case merchantId = "merchant_id"
        case storeId = "store_id"
        case rewardId = "reward_id"
        case isRedeemed = "is_redeemed"
        case pointsAccumulated = "points_accumulated"
//        case redeemDate = "redeem_date"
        case createAt = "created_at"
        case updatedAt = "updated_at"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.merchantId = try container.decode(Int.self, forKey: .merchantId)
        self.storeId = try container.decode(Int.self, forKey: .storeId)
        self.rewardId = try container.decode(Int.self, forKey: .rewardId)
        self.isRedeemed = try container.decode(Bool.self, forKey: .isRedeemed)
        self.pointsAccumulated = try container.decode(Int.self, forKey: .pointsAccumulated ) ?? 0
//        self.redeemDate = try container.decode(Any?.self, forKey: .redeemDate)
        self.createdAt = try container.decode(String.self, forKey: .createAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }


    func convertToItemModel() -> AccumulationRewardItemModel{
        AccumulationRewardItemModel(userID: userId, merchantID: merchantId, storeID: storeId, point: pointsAccumulated)
    }
}
