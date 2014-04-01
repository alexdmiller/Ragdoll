package apg.ragdoll.server.states;

class BaseGameState implements GameState {
  private var game : Game;

  public function new() { }

  public function init(game : Game) {
    this.game = game;
  }

  public function addPlayer(player : Player) : GameState {
    return this;
  }
}