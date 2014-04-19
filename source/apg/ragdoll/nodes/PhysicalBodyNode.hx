package apg.ragdoll.nodes;

import ash.core.Node;
import nape.phys.Body;

import apg.ragdoll.components.Position;
import apg.ragdoll.components.Velocity;
import apg.ragdoll.components.NapeBodyProperties;
import apg.ragdoll.components.Shapes;

class PhysicalBodyNode extends Node<PhysicalBodyNode> {
  public var position : Position;
  public var velocity : Velocity;
  public var shapes : Shapes;
  public var bodyProperties : NapeBodyProperties;

  public var body(default, default) : Body;
}