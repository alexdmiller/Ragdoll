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
import nape.phys.BodyList;

import apg.ragdoll.nodes.PhysicalBodyNode;
import apg.ragdoll.nodes.MapPropertiesNode;
import apg.ragdoll.nodes.SlingNode;
import apg.ragdoll.components.NapeBodyProperties;
import apg.ragdoll.components.MapProperties;
import apg.ragdoll.components.Rotation;
import apg.ragdoll.utils.NapeUtils;

class PhysicsSystem extends System {
  public var space : Space;

  private var propertyNodes : NodeList<MapPropertiesNode>;
  private var physicalBodyNodes : NodeList<PhysicalBodyNode>;
  private var paused : Bool;
  private var engine : Engine;

  public function new() {
    super();
    space = new Space();
    paused = false;
  }

  override public function addToEngine(engine : Engine) : Void {
    this.engine = engine;
    setupMapPropertiesNodes(engine);
    setupPhysicalBodyNodes(engine);
  }

  private function setupMapPropertiesNodes(engine : Engine) : Void {
    propertyNodes = engine.getNodeList(MapPropertiesNode);
    for (node in propertyNodes) {
      setupSpace(node);
    }
    propertyNodes.nodeAdded.add(setupSpace);
  }

  private function setupSpace(node : MapPropertiesNode) {
    space.gravity = Vec2.weak(0, node.properties.gravity);
    var floor = new Body(BodyType.STATIC);
    floor.shapes.add(new Polygon(Polygon.rect(0, node.properties.mapHeight,
        node.properties.mapWidth, 1)));
    space.bodies.add(floor);
  }

  private function setupPhysicalBodyNodes(engine : Engine) : Void {
    physicalBodyNodes = engine.getNodeList(PhysicalBodyNode);
    for (node in physicalBodyNodes) {
      createNapeBody(node);
    }
    physicalBodyNodes.nodeAdded.add(createNapeBody);
  }

  private function createNapeBody(node : PhysicalBodyNode) {
    var body : Body = NapeUtils.createBody(node.bodyProperties, node.shapes);
    space.bodies.add(body);
    node.body = body;

    body.position.setxy(node.position.x, node.position.y);
    body.velocity.setxy(node.velocity.x, node.velocity.y);
    if (!node.entity.has(Rotation)) {
      node.entity.add(new Rotation());
    }
    var rotation = node.entity.get(Rotation);
    body.rotation = rotation.theta;
  }

  override public function update(time : Float) : Void {
    if (!paused) {
      space.step(time);
    }
    for (node in physicalBodyNodes) {
      // Export position to publically viewable component for other systems.
      node.position.x = node.body.position.x;
      node.position.y = node.body.position.y;
      node.velocity.x = node.body.velocity.x;
      node.velocity.y = node.body.velocity.y;

      var rotation = node.entity.get(Rotation);
      rotation.theta = node.body.rotation;
    }
  }

  public function pause() : Void {
    paused = true;
  }

  public function unpause() : Void {
    paused = false;
  }

  public function convertSlingsToForces() : Void {
    var slings = this.engine.getNodeList(SlingNode);
    var slingsArray : Array<SlingNode> = new Array<SlingNode>();
    for (sling in slings) {
      slingsArray.push(sling);
      var slingOrigin = sling.start.toVec2();
      var bodies : BodyList = this.space.bodiesUnderPoint(slingOrigin);
      // TODO: check to see what type of bodies the force was applied to
      for (body in bodies) {
        body.applyImpulse(sling.impulse(), slingOrigin);
      }
    }
    for (sling in slingsArray) {
      this.engine.removeEntity(sling.entity);
    }
  }
}
