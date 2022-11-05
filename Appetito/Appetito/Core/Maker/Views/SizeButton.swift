//
//  SizeButton.swift
//  Appetito
//
//  Created by Dario Gallegos on 5/11/22.
//

import SwiftUI

struct SizeButton: View {
    let size: PizzaSize
    @Binding var currentSize: PizzaSize
    
    var body: some View {
        Button {
            withAnimation {
                currentSize = size
            }
        } label: {
            Text(size.rawValue)
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(
                    Color.white
                        .clipShape(Circle())
                        .shadow(color:.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .opacity(currentSize == size ? 1 : 0)
                )
        }
    }
}

