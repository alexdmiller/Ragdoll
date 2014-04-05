package apg.ragdoll.server.states;

interface GameState {
  function init(gameServer : GameServer) : Void;
  function addPlayerConnection(player : PlayerConnection) : GameState;
}