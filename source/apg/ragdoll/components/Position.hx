package apg.ragdoll.components;

class Position {
  public var x : Float;
  public var y : Float;

  public function new(x : Float, y : Float) {
    this.x = x;
    this.y = y;
  }

  public function toVec2() : nape.geom.Vec2 {
    return new nape.geom.Vec2(this.x, this.y);
  }
}