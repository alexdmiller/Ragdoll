package apg.ragdoll.components;

import apg.net.MessageSocket;

class ServerConnection {
  public var messageSocket : MessageSocket;

  public function new(messageSocket : MessageSocket) {
    this.messageSocket = messageSocket;
  }
}