package apg.ragdoll.server.states;

class BaseGameState implements GameState {
  private var gameServer : GameServer;

  public function new() { }

  public function init(gameServer : GameServer) {
    this.gameServer = gameServer;
  }

  public function addPlayerConnection(player : PlayerConnection) : GameState {
    return this;
  }
}