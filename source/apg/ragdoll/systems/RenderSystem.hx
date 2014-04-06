package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;

import apg.ragdoll.nodes.RenderNode;
import apg.ragdoll.components.PhysicalBody;

class RenderSystem extends System {
  var container : DisplayObjectContainer;

  public function new(container : DisplayObjectContainer) {
    super();
    this.container = container;
  }

  override public function addToEngine(engine : Engine) : Void {
    var nodes = engine.getNodeList(RenderNode);
    for (node in nodes) {
      addToDisplay(node);
    }
    nodes.nodeAdded.add(addToDisplay );
    nodes.nodeRemoved.add( removeFromDisplay );
  }

  override public function removeFromEngine(engine : Engine) : Void {
  }

  private function addToDisplay(node : RenderNode) : Void {
    var sprite : Sprite = new Sprite();
    sprite.graphics.beginFill(0xFFFFFF);
    sprite.graphics.drawRect(0, 0, 100, 100);
    node.sprite = sprite;

    container.addChild(node.sprite);
  }

  private function removeFromDisplay( node : RenderNode ) : Void {
    container.removeChild(node.sprite);
  }

  override public function update(time : Float) : Void {
  }
}
