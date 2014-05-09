package apg.ragdoll.server.states;

import apg.ragdoll.messages.EntitiesMessage;
import ash.core.Entity;
import nape.phys.Body;
import nape.shape.Circle;
import nape.phys.BodyType;
import nape.shape.Polygon;

import apg.ragdoll.components.Shapes;

class SendInitialGameStateToPlayers extends BaseGameState implements GameState {
  override public function init(gameServer : GameServer) : GameState {
    super.init(gameServer);
    
    var entitiesMessage : EntitiesMessage = new EntitiesMessage();

    entitiesMessage.entities.push(new Entity('physics properties')
      .add(new apg.ragdoll.components.MapProperties(300, 700, 500)));

    entitiesMessage.entities.push(new Entity('circle')
      .add(new apg.ragdoll.components.ViewProperties(0xFF0000))
      .add(new Shapes([new apg.ragdoll.components.Circle(25)]))
      .add(new apg.ragdoll.components.Position(50, 100))
      .add(new apg.ragdoll.components.Velocity(0, 0))
      .add(new apg.ragdoll.components.NapeBodyProperties(BodyType.DYNAMIC)));

    entitiesMessage.entities.push(new Entity('box')
      .add(new apg.ragdoll.components.ViewProperties(0x0000FF))
      .add(new Shapes([new apg.ragdoll.components.Rectangle(50, 50)]))
      .add(new apg.ragdoll.components.Position(60, 200))
      .add(new apg.ragdoll.components.Velocity(0, 0))
      .add(new apg.ragdoll.components.NapeBodyProperties(BodyType.DYNAMIC)));

    gameServer.broadcastToPlayers(entitiesMessage);

    return this;
  }
}