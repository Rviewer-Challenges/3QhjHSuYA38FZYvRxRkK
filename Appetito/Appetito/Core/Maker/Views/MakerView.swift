//
//  MakerView.swift
//  Appetito
//
//  Created by Dario Gallegos on 31/10/22.
//

import SwiftUI

struct MakerView: View {
    
    @EnvironmentObject private var viewModel: MakerViewModel
    @State var currentSize: PizzaSize = .medium
    
    var body: some View {
        ZStack {
            VStack {
                navigationBar
                pizzaView
                
                //price
                Text("$17")
                    .font(.title.bold())
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                pizzaSizeBar
                carrouselToppings
                Spacer()
                cartButton
                Spacer()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @ViewBuilder
    func ToppingsView(toppings: [Topping], pizza: Pizza, width: CGFloat) -> some View {
        Group {
            ForEach(toppings.indices, id: \.self) { index in
                // Cada topping son 10 images...
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
                        withAnimation {
                            viewModel.addToppingForPizza(breadName: pizza.breadName, indexOfTopping: index)
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
            .environmentObject(dev.makerViewModel)
    }
}

extension MakerView {
    private var navigationBar: some View {
        HStack {
            ActionButton(imagename: "arrow.left") {}
            
            Spacer()
            Text("Pizza")
                .font(.title2)
                .foregroundColor(.black)
            Spacer()

            ActionButton(imagename: "suit.heart.fill") {}
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
                
                TabView(selection: $viewModel.currentPizza) {
                    ForEach(viewModel.allPizzas) { pizza in
                        
                        ZStack {
                            Image(pizza.breadName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            ToppingsView(toppings: pizza.toppings, pizza: pizza, width: size.width / 2 - 45)
                        }
                        .scaleEffect(currentSize == .large ? 1.05 : (currentSize == .medium ? 0.95 : 0.88))
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
    
    private var pizzaSizeBar: some View {
        HStack(spacing: 20) {
            ForEach(PizzaSize.allCases, id: \.rawValue) { size in
                SizeButton(size: size, currentSize: $currentSize)
            }
        }
        .padding(.top, 10)
    }
    
    private var carrouselToppings: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(viewModel.toppings, id: \.self) { topping in
                    CircleButton(toppingName: "\(topping)_3",
                                 isTapped: viewModel.isToppingAdded(topping: topping),
                                 valueAnimated: viewModel.currentPizza) {
                        viewModel.toppingTapped(toppingName: topping)
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
