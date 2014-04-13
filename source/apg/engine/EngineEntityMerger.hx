package apg.engine;

import ash.core.Engine;
import ash.core.Entity;

class EngineEntityMerger {
  private var engine : Engine;

  public function new(engine : Engine) {
    this.engine = engine;
  }

  public function foldInEntities(entities : Array<Entity>) : Void {
    for (entity in entities) {
      engine.addEntity(entity);
    }
  }
}