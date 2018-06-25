//
//  BufferProvider.swift
//  ARSnake
//


import UIKit
import Metal
import simd

class BufferProvider: NSObject {

  let inflightBuffersCount: Int
  fileprivate var uniformsBuffers: [MTLBuffer]
  fileprivate var avaliableBufferIndex: Int = 0
  var avaliableResourcesSemaphore:DispatchSemaphore
  
  init(device:MTLDevice, inflightBuffersCount: Int) {
    
    let sizeOfUniformsBuffer = MemoryLayout<Float>.size * (2 * float4x4.numberOfElements()) + Light.size()
    
    avaliableResourcesSemaphore = DispatchSemaphore(value: inflightBuffersCount)
    
    self.inflightBuffersCount = inflightBuffersCount
    uniformsBuffers = [MTLBuffer]()
    
    for _ in 0...inflightBuffersCount-1{
      let uniformsBuffer = device.makeBuffer(length: sizeOfUniformsBuffer, options: [])
        uniformsBuffers.append(uniformsBuffer!)
    }
  }
  
  deinit {
    for _ in 0...self.inflightBuffersCount{
      self.avaliableResourcesSemaphore.signal()
    }
  }
  
  func nextUniformsBuffer(_ projectionMatrix: float4x4, modelViewMatrix: float4x4, light: Light) -> MTLBuffer {
    
    let buffer = uniformsBuffers[avaliableBufferIndex]
    let bufferPointer = buffer.contents()
    
    var projectionMatrix = projectionMatrix
    var modelViewMatrix = modelViewMatrix
    
    memcpy(bufferPointer, &modelViewMatrix, MemoryLayout<Float>.size*float4x4.numberOfElements())
    memcpy(bufferPointer + MemoryLayout<Float>.size*float4x4.numberOfElements(), &projectionMatrix, MemoryLayout<Float>.size*float4x4.numberOfElements())
    memcpy(bufferPointer + 2*MemoryLayout<Float>.size*float4x4.numberOfElements(), light.raw(), Light.size())
    
    avaliableBufferIndex += 1
    if avaliableBufferIndex == inflightBuffersCount{
      avaliableBufferIndex = 0
    } 
    
    return buffer
  }
}
