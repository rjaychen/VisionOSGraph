//
//  GraphAppApp.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import SwiftUI

@main
struct GraphAppApp: App {
    
    @State private var viewModel = ViewModel()
    
    init(){
        PointComponent.registerComponent()
        GraphSystem.registerSystem()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }.windowStyle(.plain)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environment(viewModel)
        }
    }
}
