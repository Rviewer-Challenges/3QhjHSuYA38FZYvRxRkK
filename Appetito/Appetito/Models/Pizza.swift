//
//  Pizza.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import Foundation

struct Pizza: Identifiable, Hashable {
    var id = UUID().uuidString
    var breadName: String
}
