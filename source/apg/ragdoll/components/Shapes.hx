package apg.ragdoll.components;

class Shapes {
  public var shapes : Array<Shape>;

  public function new(?shapes : Array<Shape>) {
    this.shapes = new Array<Shape>();    
    if (shapes != null) {
      this.shapes = this.shapes.concat(shapes);
    }
  }
}