package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeState;
import flixel.addons.nape.FlxNapeSprite;

class MyState extends FlxNapeState {
  override public function create() : Void {
    super.create();
    FlxNapeState.space.gravity.setxy(0, 1000);

    createWalls(0, 0, FlxG.width, FlxG.height);

    var ball : FlxNapeSprite = new FlxNapeSprite();
    ball.makeGraphic(100, 100, FlxColor.WHITE);
    ball.createRectangularBody();
    ball.body.position.x = FlxG.width / 2;
    ball.body.position.y = FlxG.height / 2;
    ball.body.rotation = 1;
    add(ball);
  }

  override public function update() : Void {
    super.update();
  }
}