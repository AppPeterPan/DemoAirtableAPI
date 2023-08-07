//
//  Order.swift
//  Demo
//
//  Created by Peter Pan on 2023/8/8.
//

import Foundation

struct Order: Codable {
    struct Fields: Codable {
        let sugar: String
        let ice: String
        let orderer: String
        let drink: String
        var size: String
    }
    
    var id: String?
    var createdTime: String?
    var fields: Fields
}

struct OrdersResponse: Codable {
    let records: [Order]
    let offset: String?
}
