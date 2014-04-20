package apg.ragdoll.components;

class MapProperties {
  public var gravity : Float;
  public var mapWidth : Float;
  public var mapHeight : Float;

  public function new(gravity : Float, mapWidth : Float, mapHeight : Float) {
    this.gravity = gravity;
    this.mapWidth = mapWidth;
    this.mapHeight = mapHeight;
  }
}