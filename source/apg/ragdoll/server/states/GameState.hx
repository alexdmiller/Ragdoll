package apg.ragdoll.server.states;

interface GameState {
  function init(gameServer : GameServer) : GameState;
  function addPlayerConnection(player : PlayerConnection) : GameState;
}