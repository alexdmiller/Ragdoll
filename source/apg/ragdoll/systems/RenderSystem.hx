package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import apg.ragdoll.nodes.RenderNode;
import apg.ragdoll.components.PhysicalBody;

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
    sprite.graphics.beginFill(node.viewDefinition.color);
    sprite.graphics.drawRect(0, 0, node.physicalBody.width,
        node.physicalBody.height);
    node.displayObject = sprite;

    container.addChild(node.displayObject);
  }

  private function removeFromDisplay( node : RenderNode ) : Void {
    container.removeChild(node.displayObject);
  }

  override public function update(time : Float) : Void {
    for (node in nodes) {
      node.displayObject.x = node.physicalBody.x;
      node.displayObject.y = node.physicalBody.y;
    }
  }
}
