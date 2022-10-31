//
//  Topping.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import Foundation

struct Topping: Identifiable {
    var id = UUID().uuidString
    var toppingName: String
    var isAdded: Bool = false
    var randomToppingPostions: [CGSize] = []
}
