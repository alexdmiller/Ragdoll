package apg.ragdoll.server;

import apg.net.MessageSocket;
import apg.ragdoll.common.messages.PlayerInfoMessage;

class PlayerConnection {
  public var socket(default, null) : MessageSocket;
  public var name(default, null) : String;

  public function new(socket : MessageSocket, playerInfo : PlayerInfoMessage) {
    this.socket = socket;
    this.name = playerInfo.name;
  }
}