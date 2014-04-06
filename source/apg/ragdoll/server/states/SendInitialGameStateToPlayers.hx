package apg.ragdoll.server.states;

import apg.ragdoll.messages.GameComponentsMessage;

class SendInitialGameStateToPlayers extends BaseGameState implements GameState {
  override public function init(gameServer : GameServer) : GameState {
    super.init(gameServer);
    var gameComponents : GameComponentsMessage = new GameComponentsMessage();
    gameComponents.mapName = 'My map';
    gameServer.broadcastToPlayers(gameComponents);
    return this;
  }
}