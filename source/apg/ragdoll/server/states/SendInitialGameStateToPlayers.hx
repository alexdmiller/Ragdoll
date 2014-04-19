package apg.ragdoll.server.states;

import apg.ragdoll.messages.EntitiesMessage;
import ash.core.Entity;
import nape.phys.Body;
import nape.shape.Circle;
import nape.phys.BodyType;
import nape.shape.Polygon;

class SendInitialGameStateToPlayers extends BaseGameState implements GameState {
  override public function init(gameServer : GameServer) : GameState {
    super.init(gameServer);
    
    var entitiesMessage : EntitiesMessage = new EntitiesMessage();

    entitiesMessage.entities.push(new Entity('physics properties')
      .add(new apg.ragdoll.components.MapProperties(300)));

    entitiesMessage.entities.push(new Entity('circle')
      .add(new apg.ragdoll.components.ViewProperties(0xFF0000))
      .add(new apg.ragdoll.components.Circle(50))
      .add(new apg.ragdoll.components.Position(100, 100))
      .add(new apg.ragdoll.components.Velocity(1, 0)));

    entitiesMessage.entities.push(new Entity('box')
      .add(new apg.ragdoll.components.ViewProperties(0xFF0000))
      .add(new apg.ragdoll.components.Rectangle(20, 20))
      .add(new apg.ragdoll.components.Position(100, 100))
      .add(new apg.ragdoll.components.Velocity(1, 0)));

    gameServer.broadcastToPlayers(entitiesMessage);

    return this;
  }
}