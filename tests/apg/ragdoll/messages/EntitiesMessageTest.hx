package apg.ragdoll.messages;

import haxe.Serializer;
import haxe.Unserializer;

import massive.munit.Assert;
import ash.core.Entity;

import apg.ragdoll.messages.EntitiesMessage;

class EntitiesMessageTest {
  @Test
  public function entitySerializationRoundTrip() : Void {
    var entitiesMessage : EntitiesMessage = new EntitiesMessage();
    entitiesMessage.mapName = "My map";
    var expectedEntity = new Entity('box1')
      .add(new apg.ragdoll.components.ViewProperties(0xFFFFFF))
      .add(new apg.ragdoll.components.Position(1, 2))
      .add(new apg.ragdoll.components.Velocity(3, 4));      
    entitiesMessage.entities.push(expectedEntity);

    var serialized : String = Serializer.run(entitiesMessage);
    var deserialized : EntitiesMessage = Unserializer.run(serialized);

    Assert.areEqual(entitiesMessage.mapName, deserialized.mapName);
    Assert.isNotNull(deserialized.entities);
    Assert.areEqual(1, deserialized.entities.length);

    var actualEntity = entitiesMessage.entities[0];
    Assert.isTrue(expectedEntity.has(apg.ragdoll.components.ViewProperties));
    Assert.isTrue(expectedEntity.has(apg.ragdoll.components.Position));
    Assert.isTrue(expectedEntity.has(apg.ragdoll.components.Velocity));
  }
}