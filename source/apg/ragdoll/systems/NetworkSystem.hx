package apg.ragdoll.systems;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import apg.engine.EngineEntityMerger;
import apg.net.MessageThread;
import apg.net.MessageSocket.Message;
import apg.ragdoll.messages.EntitiesMessage;
import apg.ragdoll.nodes.NetworkNode;

class NetworkSystem extends System {
  private var nodes : NodeList<NetworkNode>;
  private var engine : Engine;

  public function new() {
    super();
  }

  override public function addToEngine(engine : Engine) : Void {
    this.engine = engine;
    nodes = engine.getNodeList(NetworkNode);
    for (node in nodes) {
      initializeNetworkNode(node);
    }
    nodes.nodeAdded.add(initializeNetworkNode);
    nodes.nodeRemoved.add(tearDownNetworkNode);
  }

  override public function removeFromEngine(engine : Engine) : Void {
    for (node in nodes) {
      tearDownNetworkNode(node);
    }
    nodes = null;
    engine = null;
  }

  private function initializeNetworkNode(node : NetworkNode) : Void {
    node.messages = new MessageThread(node.socket);
    node.messages.start();
  }

  private function tearDownNetworkNode(node : NetworkNode) : Void {
    node.messages.stop();
  }

  override public function update(time : Float) : Void {
    for (node in nodes) {
      if (node.messages.hasMessage()) {
        // loop through all available messages maybe?
        var message = node.messages.popMessage();
        handleMessage(message);
      }
    }
  }

  private function handleMessage(message : Message) : Void {
    switch (Type.getClass(message)) {
      case EntitiesMessage:
        var entitiesMessage : EntitiesMessage = cast(message, EntitiesMessage);
        new EngineEntityMerger(engine).foldInEntities(entitiesMessage.entities);
      default:
        throw "NetworkSystem cannot handle message type.";
    }
  }
}
