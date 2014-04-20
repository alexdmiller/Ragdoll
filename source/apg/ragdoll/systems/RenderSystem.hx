package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import apg.ragdoll.components.Shapes;
import apg.ragdoll.components.Shape;
import apg.ragdoll.components.Circle;
import apg.ragdoll.components.Rectangle;

import apg.ragdoll.nodes.RenderNode;

class RenderSystem extends System {
  var container : DisplayObjectContainer;
  var nodes : NodeList<RenderNode>;

  public function new(container : DisplayObjectContainer) {
    super();
    this.container = container;
  }

  override public function addToEngine(engine : Engine) : Void {
    nodes = engine.getNodeList(RenderNode);
    for (node in nodes) {
      addToDisplay(node);
    }
    nodes.nodeAdded.add(addToDisplay);
    nodes.nodeRemoved.add(removeFromDisplay);
  }

  override public function removeFromEngine(engine : Engine) : Void {
    nodes = null;
  }

  private function addToDisplay(node : RenderNode) : Void {
    var sprite : Sprite = new Sprite();
    sprite.graphics.beginFill(node.viewProperties.color);

    var shapes : Shapes = node.entity.get(Shapes);
    if (shapes != null) {
      var shape : Shape = shapes.shapes[0];
      switch (Type.getClass(shape)) {
        case Circle:
          var circle : Circle = cast(shape, Circle);
          sprite.graphics.drawCircle(0, 0, circle.radius);
        case Rectangle:
          var rectangle : Rectangle = cast(shape, Rectangle);
          sprite.graphics.drawRect(-rectangle.width / 2, -rectangle.height / 2, rectangle.width,
              rectangle.height);
      }
    } else {
      sprite.graphics.drawRect(0, 0, 10, 10);
    }
    node.displayObject = sprite;

    container.addChild(node.displayObject);
  }

  private function removeFromDisplay( node : RenderNode ) : Void {
    container.removeChild(node.displayObject);
  }

  override public function update(time : Float) : Void {
    for (node in nodes) {
      node.displayObject.x = node.position.x;
      node.displayObject.y = node.position.y;
      trace(node.position);
      var rotation = node.entity.get(apg.ragdoll.components.Rotation);
      if (rotation != null) {
        node.displayObject.rotation = rotation.theta * 180 / Math.PI;
      }
    }
  }
}
