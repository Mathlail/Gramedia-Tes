//
//  DataModel.swift
//  Tokopedia Test
//
//  Created by tashya on 10/11/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import Foundation

struct DataItem {
    let name: String
    let imageURL: String
    let price: Int
    let imageURLSmall: String
    
    init(json: [String:Any]) {
        name = json["name"] as? String ?? ""
        imageURL = json["large_capsule_image"] as? String ?? ""
        price = json["final_price"] as? Int ?? 0
        imageURLSmall = json["small_capsule_image"] as? String ?? ""
    }
}
