package apg.ragdoll.server.states;

import apg.ragdoll.messages.EntitiesMessage;
import ash.core.Entity;

class SendInitialGameStateToPlayers extends BaseGameState implements GameState {
  override public function init(gameServer : GameServer) : GameState {
    super.init(gameServer);
    
    var entitiesMessage : EntitiesMessage = new EntitiesMessage();
    entitiesMessage.entities.push(new Entity('box1')
      .add(new apg.ragdoll.components.ViewDefinition(0xFFFFFF))
      .add(new apg.ragdoll.components.PhysicalBody(10, 10, 30, 30)));

    entitiesMessage.entities.push(new Entity('box2')
      .add(new apg.ragdoll.components.ViewDefinition(0xFF0000))
      .add(new apg.ragdoll.components.PhysicalBody(50, 10, 50, 50)));

    gameServer.broadcastToPlayers(entitiesMessage);

    return this;
  }
}