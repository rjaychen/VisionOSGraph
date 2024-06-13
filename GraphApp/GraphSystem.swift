//
//  GraphSystem.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import Foundation
import Observation
import RealityKit
import RealityKitContent
import QuartzCore

class PointComponent: Component {
    
}

class GraphSystem: System {
    
    private static let query = EntityQuery(where: .has(PointComponent.self))
    
    required init(scene: Scene) { }
    
    func update(context: SceneUpdateContext){
        let f = FunctionLibrary.GetFunction(name: .multiwave)
        let time = Float(CACurrentMediaTime())
        for entity in context.entities(
                    matching: Self.query,
                    updatingSystemWhen: .rendering
        ){
            var position = entity.transform.translation
            position.y = f(position.x, position.z, time)// sin(Float.pi * (position.x + time))
            entity.transform.translation = position
        }
    }
    
}
