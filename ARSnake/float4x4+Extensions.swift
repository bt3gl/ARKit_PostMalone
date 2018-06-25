//
//  float4x4+Extensions.swift
//  ARSnake
//

import Foundation
import simd
import GLKit

extension float4x4 {
  
  init() {
    self = unsafeBitCast(GLKMatrix4Identity, to: float4x4.self)
  }
  
  static func makeScale(_ x: Float, _ y: Float, _ z: Float) -> float4x4 {
    return unsafeBitCast(GLKMatrix4MakeScale(x, y, z), to: float4x4.self)
  }
  
  static func makeRotate(_ radians: Float, _ x: Float, _ y: Float, _ z: Float) -> float4x4 {
    return unsafeBitCast(GLKMatrix4MakeRotation(radians, x, y, z), to: float4x4.self)
  }
  
  static func makeTranslation(_ x: Float, _ y: Float, _ z: Float) -> float4x4 {
    return unsafeBitCast(GLKMatrix4MakeTranslation(x, y, z), to: float4x4.self)
  }
  
  static func makePerspectiveViewAngle(_ fovyRadians: Float, aspectRatio: Float, nearZ: Float, farZ: Float) -> float4x4 {
    var q = unsafeBitCast(GLKMatrix4MakePerspective(fovyRadians, aspectRatio, nearZ, farZ), to: float4x4.self)
    let zs = farZ / (nearZ - farZ)
    q[2][2] = zs
    q[3][2] = zs * nearZ
    return q
  }
  
  static func makeFrustum(_ left: Float, _ right: Float, _ bottom: Float, _ top: Float, _ nearZ: Float, _ farZ: Float) -> float4x4 {
    return unsafeBitCast(GLKMatrix4MakeFrustum(left, right, bottom, top, nearZ, farZ), to: float4x4.self)
  }
  
  static func makeOrtho(_ left: Float, _ right: Float, _ bottom: Float, _ top: Float, _ nearZ: Float, _ farZ: Float) -> float4x4 {
    return unsafeBitCast(GLKMatrix4MakeOrtho(left, right, bottom, top, nearZ, farZ), to: float4x4.self)
  }
  
  static func makeLookAt(_ eyeX: Float, _ eyeY: Float, _ eyeZ: Float, _ centerX: Float, _ centerY: Float, _ centerZ: Float, _ upX: Float, _ upY: Float, _ upZ: Float) -> float4x4 {
    return unsafeBitCast(GLKMatrix4MakeLookAt(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ), to: float4x4.self)
  }
  
  
  mutating func scale(_ x: Float, y: Float, z: Float) {
    self = self * float4x4.makeScale(x, y, z)
  }
  
  mutating func rotate(_ radians: Float, x: Float, y: Float, z: Float) {
    self = float4x4.makeRotate(radians, x, y, z) * self
  }
  
  mutating func rotateAroundX(_ x: Float, y: Float, z: Float) {
    var rotationM = float4x4.makeRotate(x, 1, 0, 0)
    rotationM = rotationM * float4x4.makeRotate(y, 0, 1, 0)
    rotationM = rotationM * float4x4.makeRotate(z, 0, 0, 1)
    self = self * rotationM
  }
  
  mutating func translate(_ x: Float, y: Float, z: Float) {
    self = self * float4x4.makeTranslation(x, y, z)
  }
  
  static func numberOfElements() -> Int {
    return 16
  }
  
  static func degrees(toRad angle: Float) -> Float {
    return Float(Double(angle) * Double.pi / 180)
  }
  
  mutating func multiplyLeft(_ matrix: float4x4) {
    let glMatrix1 = unsafeBitCast(matrix, to: GLKMatrix4.self)
    let glMatrix2 = unsafeBitCast(self, to: GLKMatrix4.self)
    let result = GLKMatrix4Multiply(glMatrix1, glMatrix2)
    self = unsafeBitCast(result, to: float4x4.self)
  }
  
}
