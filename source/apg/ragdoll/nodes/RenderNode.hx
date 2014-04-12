package apg.ragdoll.nodes;

import flash.display.DisplayObject;

import ash.core.Node;

import apg.ragdoll.components.ViewDefinition;
import apg.ragdoll.components.PhysicalBody;

class RenderNode extends Node<RenderNode> {
  public var viewDefinition : ViewDefinition;
  public var physicalBody : PhysicalBody;

  public var displayObject(default, default) : DisplayObject;
}