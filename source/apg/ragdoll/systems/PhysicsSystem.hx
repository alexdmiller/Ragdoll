package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import nape.space.Space;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Circle;

import apg.ragdoll.nodes.PhysicalBodyNode;
import apg.ragdoll.nodes.MapPropertiesNode;
import apg.ragdoll.components.NapeBodyProperties;
import apg.ragdoll.components.MapProperties;

class PhysicsSystem extends System {
  private var propertyNodes : NodeList<MapPropertiesNode>;
  private var physicalBodyNodes : NodeList<PhysicalBodyNode>;
  private var space : Space;

  public function new() {
    super();
    space = new Space();

    var circle = new Circle(50);
    trace(circle.radius);
  }

  override public function addToEngine(engine : Engine) : Void {
    setupMapPropertiesNodes(engine);
    setupPhysicalBodyNodes(engine);
  }

  private function setupMapPropertiesNodes(engine : Engine) : Void {
    propertyNodes = engine.getNodeList(MapPropertiesNode);
    for (node in propertyNodes) {
      space.gravity = Vec2.weak(0, node.properties.gravity);
    }
    propertyNodes.nodeAdded.add(function(node : MapPropertiesNode){
      space.gravity = Vec2.weak(0, node.properties.gravity);
    });
  }

  private function setupPhysicalBodyNodes(engine : Engine) : Void {
    // TODO: handle creation of physics bodies
    physicalBodyNodes = engine.getNodeList(PhysicalBodyNode);
    for (node in physicalBodyNodes) {
      createNapeBody(node);
    }
    physicalBodyNodes.nodeAdded.add(createNapeBody);
  }

  private function createNapeBody(node : PhysicalBodyNode) {
    var body = new Body(node.bodyProperties.bodyType);
    for (shape in node.bodyProperties.shapes) {
      body.shapes.add(shape);
    }
    body.position.setxy(node.position.x, node.position.y);
    body.velocity.setxy(node.velocity.x, node.velocity.y);
    space.bodies.add(body);
    node.body = body;
  }

  override public function update(time : Float) : Void {
    space.step(time);
    for (node in physicalBodyNodes) {
      // Export position to publically viewable component for other systems.
      node.position.x = node.body.position.x;
      node.position.y = node.body.position.y;
      node.velocity.x = node.body.velocity.x;
      node.velocity.y = node.body.velocity.y;
      // TODO: export angle, other properties (?)
    }
  }
}
