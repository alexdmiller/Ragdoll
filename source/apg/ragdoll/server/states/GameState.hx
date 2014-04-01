package apg.ragdoll.server.states;

interface GameState {
  function init(game : Game) : Void;
  function addPlayer(player : Player) : GameState;
}