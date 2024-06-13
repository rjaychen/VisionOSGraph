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
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    @State var graphEntity: Entity = {
        let headAnchor = AnchorEntity(.head)
        headAnchor.position = [0, 0, -1.5]
        return headAnchor
    }()
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Welcome to the Graph App!")
                .font(.extraLargeTitle2)
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
    ContentView()
}
