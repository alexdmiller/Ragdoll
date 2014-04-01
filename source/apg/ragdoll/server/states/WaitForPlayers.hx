package apg.ragdoll.server.states;

class WaitForPlayers extends BaseGameState implements GameState {
  override public function addPlayer(player : Player) : GameState {
    this.game.players.push(player);
    if (this.game.needsPlayers()) {
      return this;
    }
    return new SendInitialGameStateToPlayers();
  }
}