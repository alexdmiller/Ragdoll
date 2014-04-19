package apg.ragdoll.utils;

import haxe.Serializer;
import haxe.Unserializer;
import massive.munit.Assert;

import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.phys.BodyType;

import apg.ragdoll.components.NapeBodyProperties;
import apg.ragdoll.components.Shapes;

class NapeUtilsTest {
  @Test
  public function createCircle() : Void {
    var circleDef = new apg.ragdoll.components.Circle(20);
    var shape : Shape = NapeUtils.createShape(circleDef);
    Assert.isTrue(shape.isCircle());
    var circle = cast(shape, Circle);
    Assert.areEqual(circleDef.radius, circle.radius);
  }

  @Test
  public function createRectangle() : Void {
    var rectDef = new apg.ragdoll.components.Rectangle(20, 10);
    var shape : Shape = NapeUtils.createShape(rectDef);
    Assert.isTrue(shape.isPolygon());
    var rectangle = cast(shape, Polygon);
    Assert.areEqual(4, rectangle.edges.length);
    Assert.areEqual(200, rectangle.area);
  }

  @Test
  public function createBodyWithOneShape() : Void {
    var circleDef = new apg.ragdoll.components.Circle(20);
    var shapes = new Shapes();
    shapes.shapes.push(circleDef);
    var properties = new NapeBodyProperties(BodyType.DYNAMIC);
    var body = NapeUtils.createBody(properties, shapes);

    Assert.areEqual(1, body.shapes.length);
    Assert.isTrue(body.shapes.at(0).isCircle());
    var circle = cast(body.shapes.at(0), Circle);
    Assert.areEqual(circleDef.radius, circle.radius);
  }

  @Test
  public function createBodyWithTwoShapes() : Void {
    var circleDef = new apg.ragdoll.components.Circle(20);
    var rectDef = new apg.ragdoll.components.Rectangle(20, 10);

    var shapes = new Shapes();
    shapes.shapes.push(circleDef);
    shapes.shapes.push(rectDef);

    var properties = new NapeBodyProperties(BodyType.DYNAMIC);
    var body = NapeUtils.createBody(properties, shapes);

    Assert.areEqual(2, body.shapes.length);
    Assert.isTrue(body.shapes.at(0).isPolygon());
    Assert.isTrue(body.shapes.at(1).isCircle());    

    var circle = cast(body.shapes.at(1), Circle);
    Assert.areEqual(circleDef.radius, circle.radius);

    var rectangle = cast(body.shapes.at(0), Polygon);
    Assert.areEqual(4, rectangle.edges.length);
    Assert.areEqual(200, rectangle.area);
  }
}