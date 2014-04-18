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

    var napeBodyProperties = new apg.ragdoll.components.NapeBodyProperties();
    napeBodyProperties.shapes.push(new Circle(50));

    entitiesMessage.entities.push(new Entity('box1')
      .add(new apg.ragdoll.components.ViewProperties(0xFF0000))
      .add(napeBodyProperties)
      .add(new apg.ragdoll.components.Position(100, 100))
      .add(new apg.ragdoll.components.Velocity(1, 0)));

    gameServer.broadcastToPlayers(entitiesMessage);

    return this;
  }
}