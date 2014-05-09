package apg.ragdoll.nodes;

import flash.display.DisplayObject;

import ash.core.Node;
import nape.phys.Body;

import apg.ragdoll.components.Position;
import apg.ragdoll.components.Vector;
import apg.ragdoll.components.Sling;

class SlingNode extends Node<SlingNode> {
  public var start : Position;
  public var end : Vector;
  public var sling : Sling;

  public function strength() : Float {
    var dx : Float = start.x - end.x;
    var dy : Float = start.y - end.y;
    var dist : Float = Math.sqrt(dx * dx + dy * dy);
    return dist * sling.strength;
  }

  public function impulse() : nape.geom.Vec2 {
    var dx : Float = end.x - start.x;
    var dy : Float = end.y - start.y;
    var angle : Float = Math.atan2(dy, dx);
    var strength = strength();
    return new nape.geom.Vec2(Math.cos(angle) * strength, Math.sin(angle) * strength);
  }
}