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
  private var paused : Bool;

  public function new(physicsSystem : PhysicsSystem, networkSystem : NetworkSystem) {
    super();
    this.physicsSystem = physicsSystem;
    this.networkSystem = networkSystem;

    this.networkSystem.entitiesRecieved.add(onEntitiesRecieved);
  }

  public function isPaused() : Bool {
    return paused;
  }

  private function onEntitiesRecieved() : Void {
    physicsSystem.space.step(1);
    physicsSystem.pause();
    paused = true;
  }
}
