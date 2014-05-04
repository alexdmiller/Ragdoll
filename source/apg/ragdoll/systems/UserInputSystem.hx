package apg.ragdoll.systems;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;
import ash.core.Entity;

import nape.util.ShapeDebug;
import nape.util.Debug;

import apg.ragdoll.nodes.RenderNode;
import apg.ragdoll.systems.GameStateSystem;

class UserInputSystem extends System {
  private var engine : Engine;
  private var nodes : NodeList<RenderNode>;
  private var gameStateSystem : GameStateSystem;
  private var container : DisplayObjectContainer;
  private var currentSling : Entity;
  private var nextSlingId : Int;

  public function new(gameStateSystem : GameStateSystem, container : DisplayObjectContainer) {
    this.gameStateSystem = gameStateSystem;
    this.container = container;
    this.nextSlingId = 0;
    super();
  }

  override public function addToEngine(engine : Engine) : Void {
    this.engine = engine;
    nodes = engine.getNodeList(RenderNode);
    for (node in nodes) {
      addEventListeners(node);
    }
    nodes.nodeAdded.add(addEventListeners);
    nodes.nodeRemoved.add(addEventListeners);
  }

  override public function removeFromEngine(engine : Engine) : Void {
    nodes = null;
  }

  override public function update(time : Float) : Void {
    if (currentSling != null) {
      var vector = currentSling.get(apg.ragdoll.components.Vector);
      vector.x = container.mouseX;
      vector.y = container.mouseY;
    }
  }

  private function addEventListeners(node : RenderNode) : Void {
    node.displayObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
  }

  private function onMouseDown(event : MouseEvent) : Void {
    if (gameStateSystem.isPaused()) {
      currentSling = new Entity('sling' + nextSlingId)
          .add(new apg.ragdoll.components.Position(container.mouseX, container.mouseY))
          .add(new apg.ragdoll.components.Vector(container.mouseX, container.mouseY))
          .add(new apg.ragdoll.components.ViewProperties(0xFFFFFF));
      engine.addEntity(currentSling);
      nextSlingId++;
    }
  }

  private function onMouseUp(event : MouseEvent) : Void {
    currentSling = null;
  }
}
