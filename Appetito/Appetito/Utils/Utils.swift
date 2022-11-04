//
//  Utils.swift
//  Appetito
//
//  Created by Dario Gallegos on 4/11/22.
//

import Foundation

struct Utils {
    
    func getRandomCGSizeList(for elements: Int) -> [CGSize] {
        var list: [CGSize] = []
        for _ in 1...elements {
            list.append(CGSize(width: .random(in: -20...50), height: .random(in: -45...45)))
        }
        return list
    }
}
