
struct Vertex {
  
  var x,y,z: Float     // position data
  var r,g,b,a: Float   // color data
  var s,t: Float       // texture coordinates
  var nX,nY,nZ: Float  // normal
  
  func floatBuffer() -> [Float] {
    return [x,y,z,r,g,b,a,s,t,nX,nY,nZ]
  }
  
};
