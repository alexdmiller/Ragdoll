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
import apg.ragdoll.systems.PhysicsSystem;
import apg.ragdoll.systems.PhysicsDebugRenderSystem;
import apg.ragdoll.systems.GameStateSystem;
import apg.ragdoll.systems.UserInputSystem;
import apg.ragdoll.messages.PlayerInfoMessage;

class Game {
  private var container : Sprite;

  public function new(container : Sprite) {
    this.container = container;
    init();
  }

  private function init() {
    var socket = new Socket();
    // TODO: handle retry logic when connection fails
    socket.connect(new sys.net.Host("localhost"), 9999);
    var messageSocket : MessageSocket = new HaxeMessageSocket(socket);

    var physicsSystem = new PhysicsSystem();
    var networkSystem = new NetworkSystem();
    var renderSystem = new RenderSystem(container);
    var gameStateSystem = new GameStateSystem(physicsSystem, networkSystem);
    var userInputSystem = new UserInputSystem(gameStateSystem, container);

    var engine = new Engine();
    engine.addSystem(networkSystem, 1);
    engine.addSystem(physicsSystem, 2);
    engine.addSystem(renderSystem, 3);
    engine.addSystem(userInputSystem, 5);
    engine.addSystem(gameStateSystem, 6);
    // engine.addSystem(new PhysicsDebugRenderSystem(physicsSystem, container), 4);

    engine.addEntity(new Entity('socket')
      .add(new apg.ragdoll.components.ServerConnection(messageSocket)));

    messageSocket.send(PlayerInfoMessage.withName(Std.string(Std.random(20))));

    var tickProvider = new FrameTickProvider(container);
    tickProvider.add(engine.update);
    tickProvider.start();
  }
}