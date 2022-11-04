//
//  MakerViewModel.swift
//  Appetito
//
//  Created by Dario Gallegos on 3/11/22.
//

import SwiftUI

class MakerViewModel: ObservableObject {
    
    @Published var allPizzas: [Pizza] = []
    @Published var currentPizza: String = "Bread_1"
    
    let toppings: [String] = ["Basil", "Onion", "Broccoli", "Mushroom", "Sausage"]
    
    init() {
        addAllPizzas()
    }
    
    func addAllPizzas() {
        allPizzas = (1...5).map { Pizza(breadName: "Bread_\($0)") }
    }
    
    func toppingTapped(toppingName: String) {
        if isToppingAdded(topping: toppingName) {
            //removing it
            removeTopping(topping: toppingName)
        }
        else {
            // add topping
            let positions = Utils().getRandomCGSizeList(for: 20)
            let toppingObject = Topping(toppingName: toppingName, randomToppingPostions: positions)
            
            withAnimation {
                allPizzas[getIndex(breadName: currentPizza)].toppings.append(toppingObject)
            }
        }
        
    }
    
    func addToppingForPizza(breadName: String, indexOfTopping: Int) {
        allPizzas[getIndex(breadName: breadName)].toppings[indexOfTopping].isAdded = true
    }
    
    func isToppingAdded(topping: String) -> Bool {
        let status = allPizzas[getIndex(breadName: currentPizza)].toppings.contains { currentTopping in
            return currentTopping.toppingName == topping
        }
        return status
    }
    
    func removeTopping(topping: String) {
        let indexPizza = getIndex(breadName: currentPizza)
        let indexTopping = allPizzas[indexPizza].toppings.firstIndex { topping == $0.toppingName }
        
        if let indexTopping = indexTopping {
            allPizzas[indexPizza].toppings.remove(at: indexTopping)
        }
    }
    
    private func getIndex(breadName: String) -> Int {
        let index = allPizzas.firstIndex { pizza in
            return pizza.breadName == breadName
        } ?? 0
        
        return index
    }
}
