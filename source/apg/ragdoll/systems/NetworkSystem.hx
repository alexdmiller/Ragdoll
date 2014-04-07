package apg.ragdoll.systems;

import ash.core.System;
import ash.core.Engine;
import ash.core.NodeList;

import apg.ragdoll.nodes.NetworkNode;

class NetworkSystem extends System {
  var nodes : NodeList<NetworkNode>;

  public function new() {
    super();
  }

  override public function addToEngine(engine : Engine) : Void {
    nodes = engine.getNodeList(NetworkNode);
    for (node in nodes) {
      node.socket.setBlocking(false);
    }
  }

  override public function removeFromEngine(engine : Engine) : Void {
    nodes = null;
  }

  override public function update(time : Float) : Void {
    for (node in nodes) {

    }
  }
}
