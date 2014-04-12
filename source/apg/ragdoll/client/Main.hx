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

class Main extends Sprite {
  public function new() {
    super();
    addEventListener(Event.ADDED_TO_STAGE, init);
  }

  private function init(event) {
    var game = new Game(this);
  }
}