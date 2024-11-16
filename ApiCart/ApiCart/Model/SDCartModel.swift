//
//  SDCartModel.swift
//  ApiCart
//
//  Created by Dongik Song on 11/16/24.
//

import Foundation
import SwiftData

@Model
class SDCartModel {
    var id: Int
    var title: String
    var price: Double
    
    init(id: Int, title: String, price: Double) {
        self.id = id
        self.title = title
        self.price = price
    }
}

