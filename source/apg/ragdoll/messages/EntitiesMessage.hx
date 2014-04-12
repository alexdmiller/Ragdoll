package apg.ragdoll.messages;

import ash.core.Entity;

import apg.net.MessageSocket.Message;

class EntitiesMessage implements Message {
  public var mapName : String;
  public var entities : Array<Entity>;

  public function new() {
    entities = new Array<Entity>();
    mapName = 'unknown';
  }

  public function hxSerialize(s : haxe.Serializer) : Void {
    s.serialize(mapName);
    s.serialize(entities.length);
    for (entity in entities) {
      s.serialize(entity.name);
      for (component in entity.components) {
        s.serialize(component);
      }
      s.serialize('end');
    }
  }

  public function hxUnserialize(s : haxe.Unserializer) : Void {
    this.mapName = s.unserialize();
    this.entities = new Array<Entity>();
    var numEntities : Int = s.unserialize();
    for (i in 0...numEntities) {
      var name : String = s.unserialize();
      var entity : Entity = new Entity(name);
      var unserialized : Dynamic = s.unserialize();
      while (unserialized != 'end') {
        entity.add(unserialized);
        unserialized = s.unserialize();
      }
      this.entities.push(entity);
    }
  }
}