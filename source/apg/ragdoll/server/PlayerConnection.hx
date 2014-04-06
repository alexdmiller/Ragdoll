package apg.ragdoll.server;

import apg.net.MessageSocket;
import apg.ragdoll.common.messages.PlayerInfoMessage;

class PlayerConnection {
  private var socket : MessageSocket;
  private var name : String;

  public function new(socket : MessageSocket, playerInfo : PlayerInfoMessage) {
    this.socket = socket;
    this.name = playerInfo.name;
  }

  public function send() {

  }
}