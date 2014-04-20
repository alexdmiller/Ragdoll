package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import nape.util.ShapeDebug;
import nape.util.Debug;

class PhysicsDebugRenderSystem extends System {
  private var physicsSystem : PhysicsSystem;
  private var debug : Debug;

  public function new(physicsSystem : PhysicsSystem, container : DisplayObjectContainer) {
    super();
    this.physicsSystem = physicsSystem;
    var debug = new ShapeDebug(container.stage.stageWidth, container.stage.stageHeight, 0xFFFFFF);
    debug.thickness = 1;
    this.debug = debug;
    container.addChild(debug.display);
  }

  override public function update(time : Float) : Void {
    debug.clear();
    debug.draw(physicsSystem.space);
    debug.flush();
  }
}
