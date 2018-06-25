//
//  Light.swift
//  ARSnake
//


import Foundation

struct Light {
  
  var color: (Float, Float, Float)  // 1
  var ambientIntensity: Float       // 2
  var direction: (Float, Float, Float)
  var diffuseIntensity: Float
  var shininess: Float
  var specularIntensity: Float
    var time : Float
  static func size() -> Int {
    return MemoryLayout<Float>.size * 13
  }
  
  func raw() -> [Float] {
    let raw = [color.0, color.1, color.2, ambientIntensity, direction.0, direction.1, direction.2, diffuseIntensity, shininess, specularIntensity, time]
    return raw
  }
}
