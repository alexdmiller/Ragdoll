package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import nape.space.Space;
import nape.geom.Vec2;

import apg.ragdoll.nodes.PhysicalBodyNode;
import apg.ragdoll.nodes.MapPhysicsPropertiesNode;
import apg.ragdoll.components.PhysicalBody;
import apg.ragdoll.components.MapPhysicsProperties;

class PhysicsSystem extends System {
  private var propertyNodes : NodeList<MapPhysicsPropertiesNode>;
  private var physicsBodyNodes : NodeList<PhysicalBodyNode>;
  private var space : Space;

  public function new() {
    super();
    space = new Space();
  }

  override public function addToEngine(engine : Engine) : Void {
    setupPhysicsPropertiesNodes(engine);
    setupPhysicalBodyNodes(engine);
  }

  private function setupPhysicsPropertiesNodes(engine : Engine) : Void {
    propertyNodes = engine.getNodeList(MapPhysicsPropertiesNode);
    for (node in propertyNodes) {
      space.gravity = Vec2.weak(0, node.properties.gravity);
    }
    propertyNodes.nodeAdded.add(function(node : MapPhysicsPropertiesNode){
      space.gravity = Vec2.weak(0, node.properties.gravity);
    });
  }

  private function setupPhysicalBodyNodes(engine : Engine) : Void {

  }

  override public function update(time : Float) : Void {

  }
}
