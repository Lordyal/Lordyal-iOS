//
//  RewardModel.swift
//  Lordyal
//
//  Created by Sidney Sadel on 4/5/23.
//

import Foundation

struct RewardModel:Identifiable {
    
    var id:String = ""
    var imgURL:String = ""
    var merchantName:String = ""
    var discountDesc:String = ""
    
}

let sampleRewards:[RewardModel] = [
    RewardModel(id: UUID().uuidString, imgURL: "https://assets.simpleviewinc.com/simpleview/image/upload/crm/bucks/baskin-robbins_logo0-3eda79d95056a36_3eda7b23-5056-a36a-0b42b92fbf6a52d4.png", merchantName: "Baskin' Robins", discountDesc: "10% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://play-lh.googleusercontent.com/Gq3BZS1r1OmAPfNK3PsmDmSxNGVfwx-TS9b-YKajQ0-nuP3_C1grpFAT90UqoqWNbAkI", merchantName: "Starbucks Coffee", discountDesc: "Free Coffee"),
    RewardModel(id: UUID().uuidString, imgURL: "https://tailfin.com/wp-content/uploads/2017/01/CFA-Feature-image.jpg", merchantName: "Chic Fil A", discountDesc: "20% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://assets.simpleviewinc.com/simpleview/image/upload/crm/bucks/baskin-robbins_logo0-3eda79d95056a36_3eda7b23-5056-a36a-0b42b92fbf6a52d4.png", merchantName: "Baskin' Robins", discountDesc: "10% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://play-lh.googleusercontent.com/Gq3BZS1r1OmAPfNK3PsmDmSxNGVfwx-TS9b-YKajQ0-nuP3_C1grpFAT90UqoqWNbAkI", merchantName: "Starbucks Coffee", discountDesc: "Free Coffee"),
    RewardModel(id: UUID().uuidString, imgURL: "https://tailfin.com/wp-content/uploads/2017/01/CFA-Feature-image.jpg", merchantName: "Chic Fil A", discountDesc: "20% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://assets.simpleviewinc.com/simpleview/image/upload/crm/bucks/baskin-robbins_logo0-3eda79d95056a36_3eda7b23-5056-a36a-0b42b92fbf6a52d4.png", merchantName: "Baskin' Robins", discountDesc: "10% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://play-lh.googleusercontent.com/Gq3BZS1r1OmAPfNK3PsmDmSxNGVfwx-TS9b-YKajQ0-nuP3_C1grpFAT90UqoqWNbAkI", merchantName: "Starbucks Coffee", discountDesc: "Free Coffee"),
    RewardModel(id: UUID().uuidString, imgURL: "https://tailfin.com/wp-content/uploads/2017/01/CFA-Feature-image.jpg", merchantName: "Chic Fil A", discountDesc: "20% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://assets.simpleviewinc.com/simpleview/image/upload/crm/bucks/baskin-robbins_logo0-3eda79d95056a36_3eda7b23-5056-a36a-0b42b92fbf6a52d4.png", merchantName: "Baskin' Robins", discountDesc: "10% Off"),
    RewardModel(id: UUID().uuidString, imgURL: "https://play-lh.googleusercontent.com/Gq3BZS1r1OmAPfNK3PsmDmSxNGVfwx-TS9b-YKajQ0-nuP3_C1grpFAT90UqoqWNbAkI", merchantName: "Starbucks Coffee", discountDesc: "Free Coffee"),
    RewardModel(id: UUID().uuidString, imgURL: "https://tailfin.com/wp-content/uploads/2017/01/CFA-Feature-image.jpg", merchantName: "Chic Fil A", discountDesc: "20% Off")
]
