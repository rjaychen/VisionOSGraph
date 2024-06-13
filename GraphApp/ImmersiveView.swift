//
//  ImmersiveView.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State var viewModel = ViewModel()
    
    @State var graphEntity: Entity = {
        let headAnchor = AnchorEntity(world: .zero)
        headAnchor.position = [0, 1, -2]
        return headAnchor
    }()
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Point", in: realityKitContentBundle) {
                viewModel.makeGraph(graphEntity: graphEntity, rootEntity: scene, resolution: 30)
                // viewModel.runGraph()
                content.add(graphEntity)
                // content.add(scene)
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    @State var viewModel = ViewModel()
    ImmersiveView()
        .environment(viewModel)
}
