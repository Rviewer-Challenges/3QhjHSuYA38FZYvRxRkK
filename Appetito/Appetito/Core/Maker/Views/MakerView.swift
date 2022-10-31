//
//  MakerView.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import SwiftUI

struct MakerView: View {
    
    let pizzas: [Pizza] = [
        Pizza(breadName: "Bread_1"),
        Pizza(breadName: "Bread_2"),
        Pizza(breadName: "Bread_3"),
        Pizza(breadName: "Bread_4"),
        Pizza(breadName: "Bread_5")
    ]
    @State var currentPizza: Pizza = .init(breadName: "Bread_1")
    @State var currentSize: PizzaSize = .medium
    
    let toppings: [String] = ["Basil", "Onion", "Broccoli", "Mushroom", "Sausage"]
    
    var body: some View {
        ZStack {
            //TODO: Add backgorund color
            
            VStack {
                navigationBar
                pizzaView
                
                //price
                Text("$17")
                    .font(.title.bold())
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                //Pizza size
                HStack(spacing: 20) {
                    
                    ForEach(PizzaSize.allCases, id: \.rawValue) { size in
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
                .padding(.top, 10)
                toppingsView
                Spacer()
                cartButton
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
            let _ = proxy.size
            
            ZStack {
                Image("Plate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                
                TabView(selection: $currentPizza) {
                    ForEach(pizzas) { pizza in
                        Image(pizza.breadName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(currentSize == .large ? 1 : (currentSize == .medium ? 0.95 : 0.9))
                    }
                    .padding(40)
                }
                .tabViewStyle(.page(indexDisplayMode:.never))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 300)
    }
    
    private var toppingsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(toppings, id: \.self) { tooping in
                    Image("\(tooping)_3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .padding(12)
                        .background(
                            Color.green
                                .clipShape(Circle())
                                .opacity(0.15)
                        )
                        .padding()
                        .contentShape(Circle())
                        .onTapGesture {
                            //TODO: Add action when topping is tapped
                        }
                }
            }
        }
    }
    
    private var cartButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 15) {
                Image(systemName: "cart.fill")
                    .font(.title2)
                Text("Add to cart")
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 30)
            .foregroundColor(.white)
            .background(Color.black.opacity(0.8), in: RoundedRectangle(cornerRadius: 15))
        }

    }
}

enum PizzaSize: String, CaseIterable {
    case small = "S"
    case medium = "M"
    case large = "L"
}
