package;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;

class RagdollGame extends FlxGame {
  public function new(width : Int, height : Int) {
    super(width, height, MyState);
  }
}