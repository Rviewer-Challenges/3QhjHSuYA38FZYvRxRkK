//
//  PreviewProvider.swift
//  Appetito
//
//  Created by Dario Gallegos on 4/11/22.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    let makerViewModel = MakerViewModel()

}
