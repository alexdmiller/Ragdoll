package apg.ragdoll.server.states;

class WaitForPlayers extends BaseGameState implements GameState {
  override public function addPlayerConnection(player : PlayerConnection) : GameState {
    this.gameServer.players.push(player);
    if (this.gameServer.needsPlayers()) {
      return this;
    }
    return new SendInitialGameStateToPlayers();
  }
}