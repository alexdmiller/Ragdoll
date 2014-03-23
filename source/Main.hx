package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

import flixel.FlxG;
import flixel.FlxGame;

class Main extends Sprite {
  public function new() {
    super();
    addEventListener(Event.ADDED_TO_STAGE, init);
  }

  private function init(event) {
    var game = new RagdollGame(stage.stageWidth, stage.stageHeight);
    addChild(game);
  }
}