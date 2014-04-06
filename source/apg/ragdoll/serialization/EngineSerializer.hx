package apg.ragdoll.serialization;

import haxe.Serializer;

import ash.core.Engine;

class EngineSerializer {
  public static function run(engine : Engine) : String {
    var serializer = new Serializer();
    for (entity in engine.entities) {
      for (component in entity.components) {
        serializer.serialize(component);
      }
    }
    return serializer.toString();
  }
}