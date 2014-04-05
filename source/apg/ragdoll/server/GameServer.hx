package apg.ragdoll.server;

import apg.ragdoll.server.states.GameState;
import apg.ragdoll.server.states.BaseGameState;

@:allow(apg.ragdoll.server.states)
class GameServer {
  private var players : Array<PlayerConnection>;
  private var currentState : GameState;
  private var maxPlayers : Int;

  public function new(maxPlayers : Int) {
    this.maxPlayers = maxPlayers;
    this.players = new Array<PlayerConnection>();
    setState(new BaseGameState());
  }

  public function setState(newState : GameState) : Void {
    trace('game state -> ' + Type.getClassName(Type.getClass(newState)));
    this.currentState = newState;
    this.currentState.init(this);
  }

  public function addPlayer(player : PlayerConnection) : Void {
    setState(currentState.addPlayerConnection(player));
  }

  public function needsPlayers() : Bool {
    return this.players.length < maxPlayers;
  }

  public function broadcastToPlayers(message) : Void {
    for (player in this.players) {
      
    }
  }
}