package apg.ragdoll.server;

import apg.ragdoll.server.states.GameState;

class Game {
  private var players : Array<Player>;
  private var currentState : GameState;

  public function new(players : Array<Player>) {
    this.players = players;
  }

  public function setState(newState : GameState) : Void {

  }

  public function broadcastToPlayers(message) : Void {

  }


}