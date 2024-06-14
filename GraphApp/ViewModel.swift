//
//  ViewModel.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import Foundation
import Observation
import RealityKit
import RealityKitContent
import QuartzCore

@Observable
class ViewModel {
    public var points: Array<Entity> = Array()
    
    public var functionName: FunctionLibrary.Function = .wave
    public var graphResolution: Int = 10
    
    func createPoint(radius: Float, material: Material) -> Entity {
        let sphereResource = MeshResource.generateSphere(radius: radius)
        let myMaterial = material // SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
        let myEntity = ModelEntity(mesh: sphereResource, materials: [myMaterial])
        return myEntity
    }
    
    
    func makeGraph(graphEntity: Entity, rootEntity: Entity, resolution: Int){
        // let _ = print(rootEntity)
        let modelComponent = rootEntity.findEntity(named: "Sphere")?.components[ModelComponent.self]
        guard let shaderGraphMaterial = modelComponent?.materials.first as? ShaderGraphMaterial else { return }
        let step = Float(2) / Float(resolution)
        let scale = Float(0.5)
        let localScale = SIMD3(1, 1, 1) * step
        var position = SIMD3<Float>(0, 0, 0)
    
        var x = 0
        var z = 0
        for i in 0..<(resolution * resolution) {
            if (x == resolution) {
                x = 0
                z += 1
            }
            points.append(createPoint(radius: 1 * scale, material: shaderGraphMaterial))
            points[i].components.set(PointComponent())
            position.x = (Float(x) + Float(0.5)) * step - Float(1)
            position.z = (Float(z) + Float(0.5)) * step - Float(1)
            points[i].transform.translation = scale * position
            points[i].transform.scale = scale * localScale
            graphEntity.addChild(points[i])
            x += 1
        }
        // let _ = print(points.count)
    }
    
    func runGraph(){
        for i in 0..<points.count {
            let point = points[i]
            var position = point.transform.translation
            position.y = sin(Float.pi * (position.x + Float(CACurrentMediaTime())))
            point.transform.translation = position
        }
    }
    
    
}
