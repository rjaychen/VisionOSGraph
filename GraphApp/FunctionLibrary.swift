//
//  FunctionLibrary.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import Foundation



public class FunctionLibrary {
    
    public enum Function: Int, CaseIterable, Identifiable, CustomStringConvertible {
        case wave, multiwave, ripple, sphere, warpedsphere, warpedtorus
        public var id: Self { self }
        public var description: String {
            switch self {
            case .wave:
                return "Wave"
            case .multiwave:
                return "Multiwave"
            case .ripple:
                return "Ripple"
            case .sphere:
                return "Sphere"
            case .warpedsphere:
                return "Warped Sphere"
            case .warpedtorus:
                return "Warped Torus"
            }
        }
    }
    
    static var functions = [Wave, MultiWave, Ripple, Sphere, WarpedSphere, WarpedTorus]
    
    public static func GetFunction(name: Function) -> (Float, Float, Float) -> SIMD3<Float> {
        let f = functions[name.rawValue]
        return f
    }
    /* Cartesian 1D Coordinate Functions
    public static func Wave(x: Float, z: Float , t: Float) -> Float {
        return sin(Float.pi * (x + z + t));
    }
    public static func MultiWave (x: Float, z: Float, t: Float) -> Float {
        var y = sin(Float.pi * (x + Float(0.5) * t))
        y += Float(0.5) * sin(Float(2) * Float.pi * (z + t))
        return y * (Float(2) / Float(3))
    }
    public static func Ripple (x: Float, z: Float, t: Float) -> Float {
        let d = sqrt(x * x + z * z);
        let y = sin(Float.pi * (Float(4) * d - t));
        return y / (Float(1) + Float(10) * d);
    }
    */
    // 3D Functions
    public static func Wave (u: Float, v: Float, t: Float) -> SIMD3<Float> {
        var p = SIMD3<Float>()
        p.x = u
        p.y = sin(Float.pi * (u + v + t))
        p.z = v
        return p
    }
    public static func MultiWave (u: Float, v: Float, t: Float) -> SIMD3<Float> {
        var p = SIMD3<Float>()
        p.x = u
        p.y = sin(Float.pi * (u + Float(0.5) * t))
        p.y += Float(0.5) * sin(Float(2) * Float.pi * (v + t))
        p.y += sin(Float.pi * (u + v + Float(0.25) * t))
        p.y *= Float(1) / Float(2.5)
        p.z = v
        return p;
    }

    public static func Ripple (u: Float, v: Float, t: Float) -> SIMD3<Float> {
        let d = sqrt(u * u + v * v);
        var p = SIMD3<Float>()
        p.x = u;
        p.y = sin(Float.pi * (Float(4) * d - t));
        p.y /= Float(1) + Float(10) * d;
        p.z = v;
        return p;
    }
    public static func Sphere (u: Float, v: Float, t: Float) -> SIMD3<Float> {
        let r = Float(0.5) + Float(0.5)  * sin(Float.pi * t)
        let s = r * cos(Float(0.5) * Float.pi * v)
        var p = SIMD3<Float>()
        p.x = s * sin(Float.pi * u)
        p.y = r * sin(Float.pi * Float(0.5) * v)
        p.z = s * cos(Float.pi * u)
        return p
    }
    
    public static func WarpedSphere(u: Float, v: Float, t: Float) -> SIMD3<Float> {
        let r = Float(0.9) + Float(0.1) * sin(Float.pi * (Float(6) * u + Float(4) * v + t))
        let s = r * cos(Float(0.5) * Float.pi * v)
        var p = SIMD3<Float>()
        p.x = s * sin(Float.pi * u)
        p.y = r * sin(Float.pi * Float(0.5) * v)
        p.z = s * cos(Float.pi * u)
        return p
    }
    
    public static func WarpedTorus(u: Float, v: Float, t: Float) -> SIMD3<Float> {
        let r1 = Float(0.7) + Float(0.1) * sin(Float.pi * (Float(6) * u + Float(0.5) * t))
        let r2 = Float(0.15) + Float(0.05) * sin(Float.pi * (Float(8) * u + Float(4) * v + Float(2) * t))
        let s = r1 + r2 * cos(Float.pi * v)
        var p = SIMD3<Float>()
        p.x = s * sin(Float.pi * u);
        p.y = r2 * sin(Float.pi * v);
        p.z = s * cos(Float.pi * u);
        return p
    }
    
}
