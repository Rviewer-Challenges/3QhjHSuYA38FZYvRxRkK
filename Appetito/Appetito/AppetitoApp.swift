//
//  AppetitoApp.swift
//  Appetito
//
//  Created by Dario Gallegos on 30/10/22.
//

import SwiftUI

@main
struct AppetitoApp: App {
    
    @StateObject private var viewModel = MakerViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MakerView()
                    //.toolbar(.hidden, for: .navigationBar)
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
