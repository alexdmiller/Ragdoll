package apg.ragdoll.client;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import sys.net.Socket;
import sys.net.Host;

import ash.core.Engine;
import ash.core.Entity;
import ash.tick.FrameTickProvider;

import apg.net.MessageSocket;
import apg.net.HaxeMessageSocket;
import apg.ragdoll.systems.RenderSystem;
import apg.ragdoll.messages.PlayerInfoMessage;
import apg.ragdoll.messages.GameComponentsMessage;

class Main extends Sprite {
  public function new() {
    super();
    addEventListener(Event.ADDED_TO_STAGE, init);
  }

  private function init(event) {
    /*var socket = new Socket();
    socket.connect(new sys.net.Host("localhost"), 9999);
    var messageSocket : MessageSocket = new HaxeMessageSocket(socket);
    messageSocket.send(PlayerInfoMessage.withName(Std.string(Std.random(20))));

    var gameComponents : GameComponentsMessage =
        cast(messageSocket.recieve(), GameComponentsMessage);*/
    var game = new Game(this);
  }
}