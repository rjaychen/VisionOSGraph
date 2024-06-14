//
//  ContentView.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Welcome to the Graph App!")
                .font(.extraLargeTitle2)
            Section("Select A Function to Graph:"){
                Picker("Function", selection:
                        $viewModel.functionName){
                    ForEach(FunctionLibrary.Function.allCases) { option in
                        Text(String(describing: option))
                    }
                }
            }
            Button("Random Function!"){
                viewModel.functionName = FunctionLibrary.Function(rawValue: Int.random(in: 0..<6)) ?? .wave
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        })
        .padding(50)
        .glassBackgroundEffect()
        .onAppear(perform: {
            Task{
                await openImmersiveSpace(id: "ImmersiveSpace")
            }
        })
    }
}

#Preview(windowStyle: .plain) {
    @State var viewModel = ViewModel()
    ContentView()
        .environment(viewModel)
}
