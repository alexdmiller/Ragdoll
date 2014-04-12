package apg.ragdoll.client;

import flash.display.Sprite;
import flash.display.DisplayObjectContainer;
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
import apg.ragdoll.systems.NetworkSystem;
import apg.ragdoll.messages.PlayerInfoMessage;

class Game {
  private var container : DisplayObjectContainer;

  public function new(container : DisplayObjectContainer) {
    this.container = container;
    init();
  }

  private function init() {
    var socket = new Socket();
    // TODO: handle retry logic when connection fails
    socket.connect(new sys.net.Host("localhost"), 9999);
    var messageSocket : MessageSocket = new HaxeMessageSocket(socket);

    var engine = new Engine();
    engine.addSystem(new NetworkSystem(), 1);
    engine.addSystem(new RenderSystem(container), 2);

    engine.addEntity(new Entity('socket')
      .add(new apg.ragdoll.components.ServerConnection(messageSocket)));

    messageSocket.send(PlayerInfoMessage.withName(Std.string(Std.random(20))));

    var tickProvider = new FrameTickProvider(container);
    tickProvider.add(engine.update);
    tickProvider.start();
  }
}