//
//  FunctionLibrary.swift
//  GraphApp
//
//  Created by Ryan Chen on 6/13/24.
//

import Foundation



public class FunctionLibrary {
    
    public enum Function: Int{
        case wave, multiwave, ripple
    }
    
    static var functions = [Wave, MultiWave, Ripple]
    
    public static func GetFunction(name: Function) -> (Float, Float, Float) -> Float {
        let f = functions[name.rawValue]
        return f
    }
    
    public static func Wave(x: Float, z: Float , t: Float) -> Float {
        return sin(Float.pi * (x + z + t));
    }
    public static func MultiWave (x: Float, z: Float, t: Float) -> Float {
        var y = sin(Float.pi * (x + Float(0.5) * t))
        y += Float(0.5) * sin(Float(2) * Float.pi * (z + t))
        return y * (Float(2) / Float(3))
    }
    public static func Ripple (x: Float, z: Float, t: Float) -> Float {
        let d = abs(x);
        let y = sin(Float.pi * (Float(4) * d - t));
        return y / (Float(1) + Float(10) * d);
    }
}
