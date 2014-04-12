package apg.ragdoll.systems;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import apg.net.MessageThread;
import apg.ragdoll.messages.EntitiesMessage;
import apg.ragdoll.nodes.NetworkNode;

class NetworkSystem extends System {
  var nodes : NodeList<NetworkNode>;

  public function new() {
    super();
  }

  override public function addToEngine(engine : Engine) : Void {
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
  }

  private function initializeNetworkNode(node : NetworkNode) : Void {
    node.messages = new MessageThread(node.socket);
    node.messages.start();
  }

  private function tearDownNetworkNode(node : NetworkNode) : Void {
    node.messages.stop();
  }

  // should this be in a thread by itself?
  override public function update(time : Float) : Void {
    for (node in nodes) {
      if (node.messages.hasMessage()) {
        var message = node.messages.popMessage();
        trace("Got message!");
        trace(message);
      }
    }
  }
}
