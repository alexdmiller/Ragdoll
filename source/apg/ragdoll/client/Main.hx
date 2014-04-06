package apg.ragdoll.client;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import sys.net.Socket;
import sys.net.Host;

import apg.net.MessageSocket;
import apg.net.HaxeMessageSocket;
import apg.ragdoll.common.messages.PlayerInfoMessage;
import apg.ragdoll.common.messages.GameComponentsMessage;

class Main extends Sprite {
  public function new() {
    super();
    addEventListener(Event.ADDED_TO_STAGE, init);
  }

  private function init(event) {
    var socket = new Socket();
    socket.connect(new sys.net.Host("localhost"), 9999);
    var messageSocket : MessageSocket = new HaxeMessageSocket(socket);
    messageSocket.send(PlayerInfoMessage.withName(Std.string(Std.random(20))));

    var gameComponents : GameComponentsMessage =
        cast(messageSocket.recieve(), GameComponentsMessage);
    trace(gameComponents);
  }
}