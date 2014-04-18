package apg.ragdoll.components;

import nape.shape.Shape;
import nape.phys.BodyType;

class NapeBodyProperties {
  public var shapes : Array<Shape>;
  public var bodyType : BodyType;

  public function new() {
    shapes = new Array<Shape>();
    bodyType = BodyType.DYNAMIC;
  }
}