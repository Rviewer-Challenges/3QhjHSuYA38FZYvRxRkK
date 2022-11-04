//
//  Pizza.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import Foundation

struct Pizza: Identifiable {
    var id = UUID().uuidString
    var breadName: String
    var toppings: [Topping] = []
    var size: PizzaSize = .medium
}

enum PizzaSize: String, CaseIterable {
    case small = "S"
    case medium = "M"
    case large = "L"
}
