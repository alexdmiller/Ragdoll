package apg.ragdoll.utils;

import apg.ragdoll.components.NapeBodyProperties;
import apg.ragdoll.components.Shapes;
import nape.phys.Body;

class NapeUtils {
  public static function createShape(shapeDef : apg.ragdoll.components.Shape) : nape.shape.Shape {
    switch (Type.getClass(shapeDef)) {
      case apg.ragdoll.components.Circle:
        var circleDef = cast(shapeDef, apg.ragdoll.components.Circle);
        return new nape.shape.Circle(circleDef.radius);
      case apg.ragdoll.components.Rectangle:
        var rectDef = cast(shapeDef, apg.ragdoll.components.Rectangle);
        return new nape.shape.Polygon(nape.shape.Polygon.box(rectDef.width, rectDef.height));
      default:
        return null;
    }
  }

  public static function createBody(properties : NapeBodyProperties, shapes : Shapes) : Body {
    var body = new Body(properties.bodyType);
    for (shapeDef in shapes.shapes) {
      body.shapes.add(createShape(shapeDef));
    }
    return body;
  }
}