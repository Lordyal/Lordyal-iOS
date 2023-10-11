//
//  InvocationURLModel.swift
//  Lordyal
//
//  Created by Chau Nguyen on 10/7/23.
//

import Foundation

class InvocationURLModel: ObservableObject {
    @Published var orderID: String = ""
    @Published var storeID: String = ""
    @Published var merchantID: String = ""
    @Published var token: String = ""
    @Published var points: Int = 0
    @Published var storeName: String = ""
}
