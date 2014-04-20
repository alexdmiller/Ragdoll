package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import nape.util.ShapeDebug;
import nape.util.Debug;

class GameStateSystem extends System {
  private var physicsSystem : PhysicsSystem;
  private var networkSystem : NetworkSystem;

  public function new(physicsSystem : PhysicsSystem, networkSystem : NetworkSystem) {
    super();
    this.physicsSystem = physicsSystem;
    this.networkSystem = networkSystem;

    this.networkSystem.entitiesRecieved.add(onEntitiesRecieved);
  }

  private function onEntitiesRecieved() : Void {
    trace("ASDSAD");
    //physicsSystem.pause();
  }
}
