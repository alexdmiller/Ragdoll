package apg.ragdoll.client;

import flash.display.Sprite;
import flash.events.Event;
import flash.net.Socket;
import flash.Lib;


class Main extends Sprite {
  public function new() {
    super();
    addEventListener(Event.ADDED_TO_STAGE, init);
  }

  private function init(event) {
    var socket = new Socket('localhost', 9999);
  }
}