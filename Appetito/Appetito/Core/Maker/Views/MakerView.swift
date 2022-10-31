//
//  MakerView.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import SwiftUI

struct MakerView: View {
    var body: some View {
        ZStack {
            //TODO: Add backgorund color
            
            VStack {
                navigationBar
                pizzaView
                
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct MakerView_Previews: PreviewProvider {
    static var previews: some View {
        MakerView()
    }
}

extension MakerView {
    private var navigationBar: some View {
        HStack {
            ActionButton(imagename: "arrow.left") {
                
            }
            
            Spacer()
            Text("Pizza")
                .font(.title2)
                .foregroundColor(.black)
            Spacer()

            ActionButton(imagename: "suit.heart.fill") {
                
            }
        }
        .padding()
    }
    
    private var pizzaView: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                Image("Plate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 300)
    }
}
