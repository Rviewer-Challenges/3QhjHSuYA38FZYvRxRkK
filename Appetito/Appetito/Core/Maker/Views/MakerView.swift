//
//  MakerView.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import SwiftUI

struct MakerView: View {
    
    @State var pizzas: [Pizza] = [
        Pizza(breadName: "Bread_1"),
        Pizza(breadName: "Bread_2"),
        Pizza(breadName: "Bread_3"),
        Pizza(breadName: "Bread_4"),
        Pizza(breadName: "Bread_5")
    ]
    @State var currentPizza = "Bread_1"
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
                carrouselToppings
                Spacer()
                cartButton
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func getIndex(breadName: String) -> Int {
        let index = pizzas.firstIndex { pizza in
            return pizza.breadName == breadName
        } ?? 0
        return index
    }
    
    func isAdded(topping: String)->Bool {
         let status = pizzas[getIndex(breadName: currentPizza)].toppings.contains { currentTopping in
            return currentTopping.toppingName == topping
        }
        return status
    }
    
    @ViewBuilder
    func ToppingsView(toppings: [Topping], pizza: Pizza, width: CGFloat) -> some View {
        Group {
            ForEach(toppings.indices, id: \.self) { index in
                // cada topin son 10 images de topping
                let topping = toppings[index]
                ZStack {
                    
                    ForEach(1...20, id: \.self) { subIndex in
                        
                        // 360 / 10 toppings = 36
                        let rotation = Double(subIndex) * 36 // para intentar poner los toppings en posiciones aleatorias
                        let centerIndex = (subIndex > 10 ? (subIndex - 10) : subIndex)
                        
                        
                        Image("\(topping.toppingName)_\(centerIndex)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                        //subindex - 1 para que el random index empiece desde 0
                            .offset(x: (width / 2) - topping.randomToppingPostions[subIndex - 1].width,
                                    y: topping.randomToppingPostions[subIndex - 1].height)
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                // Adding Scaling Animation...
                // Triggering Scaling animation when the topping is added...
                .scaleEffect(topping.isAdded ? 1 : 10,  anchor: .center)
                .onAppear {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                        
                        withAnimation{
                            pizzas[getIndex(breadName: pizza.breadName)].toppings[index].isAdded = true
                        }
                    }
                }
            }
             
        }
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
                
                TabView(selection: $currentPizza) {
                    ForEach(pizzas) { pizza in
                        
                        ZStack {
                            Image(pizza.breadName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            ToppingsView(toppings: pizza.toppings, pizza: pizza, width: size.width / 2 - 45)
                        }
                        .scaleEffect(currentSize == .large ? 1 : (currentSize == .medium ? 0.95 : 0.9))
                        .tag(pizza.breadName)

                    }
                    .padding(40)
                }
                .tabViewStyle(.page(indexDisplayMode:.never))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 300)
    }
    
    private var carrouselToppings: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(toppings, id: \.self) { topping in
                    Image("\(topping)_3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .padding(12)
                        .background(
                            Color.green
                                .clipShape(Circle())
                                .opacity(isAdded(topping: topping) ? 0.15 : 0)
                                .animation(.easeInOut, value: currentPizza)
                        )
                        .padding()
                        .contentShape(Circle())
                        .onTapGesture {
                            //TODO: Add random position to toppings
                            
                            if isAdded(topping: topping){
                                // getting index and removing it...
                                if let index = pizzas[getIndex(breadName: currentPizza)].toppings.firstIndex(where: { currentTopping in
                                    return topping == currentTopping.toppingName
                                }){
                                    pizzas[getIndex(breadName: currentPizza)].toppings.remove(at: index)
                                }
                                
                                return
                            }
                            
                            //random positions
                            var positions: [CGSize] = []
                            for _ in 1...20 {
                                positions.append(CGSize(width: .random(in: -20...50), height: .random(in: -45...45)))
                            }
                            
                            
                            let toppingObject = Topping(toppingName: topping, randomToppingPostions: positions)
                            withAnimation {
                                pizzas[getIndex(breadName: currentPizza)].toppings.append(toppingObject)
                            }
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
