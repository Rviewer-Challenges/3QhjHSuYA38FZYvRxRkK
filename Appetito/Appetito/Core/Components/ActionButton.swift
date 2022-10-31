//
//  ActionButton.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import SwiftUI

struct ActionButton: View {
    
    let imagename: String
    let action: (() -> ())?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: imagename)
                .font(.title2)
                .foregroundColor(.black)
        }
    }
}
