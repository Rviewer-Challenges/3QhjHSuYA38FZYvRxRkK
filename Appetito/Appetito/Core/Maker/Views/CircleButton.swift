//
//  CircleButton.swift
//  Appetito
//
//  Created by Dario Gallegos on 5/11/22.
//

import SwiftUI

struct CircleButton: View {
    let toppingName: String
    let isTapped: Bool
    let valueAnimated: String
    let action: (() -> ())?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(toppingName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44)
                .padding(12)
                .background(
                    Color.green
                        .clipShape(Circle())
                        .opacity(isTapped ? 0.15 : 0)
                        .animation(.easeInOut, value: valueAnimated)
                )
                .padding()
                .contentShape(Circle())

        }
    }
}
