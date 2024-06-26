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

class PointComponent: Component { } // Added at initialization of graph

class GraphSystem: System {
    
    static var functionName: FunctionLibrary.Function = .wave
    static var resolution: Int = 20
    
    private static let query = EntityQuery(where: .has(PointComponent.self))
    
    required init(scene: Scene) { 
        
    }
    
    func update(context: SceneUpdateContext){
        let f = FunctionLibrary.GetFunction(name: GraphSystem.functionName)
        let time = Float(CACurrentMediaTime())
        let step = Float(2) / Float(GraphSystem.resolution) // Make sure to set this to resolution!!!!
        var u: Float
        var v: Float = (Float(0.5)) * step - Float(1)
        var x = 0
        var z = 0
        for (_, entity) in context.entities(
                    matching: Self.query,
                    updatingSystemWhen: .rendering
        ).enumerated(){
            if (x == GraphSystem.resolution){
                x = 0
                z += 1
                v = (Float(z) + Float(0.5)) * step - Float(1)
            }
            u = (Float(x) + Float(0.5)) * step - Float(1)
            entity.transform.translation = f(u, v, time)
            x += 1
        }
    }
    
    
    
}
