package apg.ragdoll.nodes;

import flash.display.DisplayObject;

import ash.core.Node;

import apg.ragdoll.components.ServerConnection;
import apg.net.MessageSocket;

class NetworkNode extends Node<NetworkNode> {
  public var serverConnection : ServerConnection;

  public var socket(get, null) : MessageSocket;

  private function get_socket() : MessageSocket {
    return serverConnection.messageSocket;
  }
}