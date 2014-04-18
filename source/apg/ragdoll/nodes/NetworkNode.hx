package apg.ragdoll.nodes;

import ash.core.Node;

import apg.ragdoll.components.ServerConnection;
import apg.net.MessageThread;
import apg.net.MessageSocket;

class NetworkNode extends Node<NetworkNode> {
  public var serverConnection : ServerConnection;

  public var socket(get, null) : MessageSocket;
  public var messages(default, default) : MessageThread;

  private function get_socket() : MessageSocket {
    return serverConnection.messageSocket;
  }
}