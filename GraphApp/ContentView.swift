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
    
    @State private var isPressed = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = true
    
    let resolutions = [10, 20, 30, 40, 50]
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Welcome to the Graph App!")
                .font(.extraLargeTitle2)
            Section("Select A Function to Graph:"){
                HStack{
                    Picker("Function", selection:
                            $viewModel.functionName){
                        ForEach(FunctionLibrary.Function.allCases) { option in
                            Text(String(describing: option))
                        }
                    }
                    Button("Random Function!"){
                        viewModel.functionName = FunctionLibrary.Function(rawValue: Int.random(in: 0..<6)) ?? .wave
                    }
                    .buttonStyle(.bordered)
                    .tint(LinearGradient(colors: [.pink, .blue, .indigo], startPoint: UnitPoint(x: 1, y: 1), endPoint: UnitPoint(x: -1, y: -1)))
                }
            }
            Section("Resolution:"){
                Picker("Resolution", selection: $viewModel.graphResolution){
                    ForEach(resolutions, id: \.self){
                        Text("\($0)")
                    }
                }.pickerStyle(.segmented)
                    .frame(width:500)
            }
            Button(isPressed ? "Close Graph" : "Run Graph") {
                isPressed.toggle()
            }
            .foregroundColor(isPressed ? .red : .green)
        })
        .padding(50)
        .glassBackgroundEffect()
        .onChange(of: isPressed) { (_, new) in
            Task {
                if new {
                    GraphSystem.functionName = viewModel.functionName
                    GraphSystem.resolution = viewModel.graphResolution
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened: immersiveSpaceIsShown = true
                    case .error: fallthrough
                    case .userCancelled: fallthrough
                    @unknown default: immersiveSpaceIsShown = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}


#Preview(windowStyle: .plain) {
    @State var viewModel = ViewModel()
    ContentView()
        .environment(viewModel)
}
