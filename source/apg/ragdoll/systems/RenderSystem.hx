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
import apg.ragdoll.components.Vector;

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
    }

    var vector : Vector = node.entity.get(Vector);
    if (vector != null) {
      sprite.graphics.lineStyle(2, node.viewProperties.color, 1);
      sprite.graphics.moveTo(0, 0);
      sprite.graphics.lineTo(vector.x, vector.y);
      sprite.x = node.position.x;
      sprite.y = node.position.y;
    }

    node.displayObject = sprite;

    container.addChild(node.displayObject);
  }

  private function removeFromDisplay(node : RenderNode) : Void {
    container.removeChild(node.displayObject);
  }

  override public function update(time : Float) : Void {
    for (node in nodes) {
      if (node.entity.get(Shapes) != null)
        node.displayObject.x = node.position.x;
        node.displayObject.y = node.position.y;
        var rotation = node.entity.get(apg.ragdoll.components.Rotation);
        if (rotation != null) {
          node.displayObject.rotation = rotation.theta * 180 / Math.PI;
      } else if (node.entity.get(Vector) != null) {
        var vector : Vector = node.entity.get(Vector);
        node.displayObject.graphics.clear();
        node.displayObject.graphics.lineStyle(2, node.viewProperties.color, 1);
        node.displayObject.graphics.moveTo(0, 0);
        node.displayObject.graphics.lineTo(vector.x - node.displayObject.x,
                                           vector.y - node.displayObject.y);
      }
    }
  }
}
