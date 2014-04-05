package apg.ragdoll.server;

import sys.net.Socket;

class PlayerConnection {
  private var socket : Socket;
  private var name : String;

  public function new(socket : Socket) {
    this.socket = socket;
  }

  public function send() {

  }
}