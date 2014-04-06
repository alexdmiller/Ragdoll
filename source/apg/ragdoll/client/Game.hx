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
import apg.ragdoll.serialization.EngineSerializer;
import apg.ragdoll.messages.PlayerInfoMessage;
import apg.ragdoll.messages.GameComponentsMessage;

class Game {
  private var container : DisplayObjectContainer;

  public function new(container : DisplayObjectContainer) {
    this.container = container;
    init();
  }

  private function init() {
    /*var socket = new Socket();
    socket.connect(new sys.net.Host("localhost"), 9999);
    var messageSocket : MessageSocket = new HaxeMessageSocket(socket);
    messageSocket.send(PlayerInfoMessage.withName(Std.string(Std.random(20))));

    var gameComponents : GameComponentsMessage =
        cast(messageSocket.recieve(), GameComponentsMessage);*/

    var engine = new Engine();
    engine.addSystem(new RenderSystem(container), 1);

    var entity = new Entity('box')
      .add(new apg.ragdoll.components.ViewDefinition('my view'))
      .add(new apg.ragdoll.components.PhysicalBody(10, 10));
    engine.addEntity(entity);

    var tickProvider = new FrameTickProvider(container);
    tickProvider.add(engine.update);
    tickProvider.start();
  }
}