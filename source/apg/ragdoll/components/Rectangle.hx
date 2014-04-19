package apg.ragdoll.components;

class Rectangle implements Shape {
  public var width : Float;
  public var height : Float;

  public function new(width : Float, height : Float) {
    this.width = width;
    this.height = height;
  }
}