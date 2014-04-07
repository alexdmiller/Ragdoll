package apg.ragdoll.nodes;

import flash.display.DisplayObject;

import ash.core.Node;

import apg.ragdoll.components.ViewDefinition;
import apg.ragdoll.components.PhysicalBody;

/**
 * Node for rendering. Note that here it demonstrates how nodes work:
 *
 * component system treats all variables (both public and private) as links to required components
 * and sets their values on node initialization, while properties and functions are ignored completely
 * and can be used to make node API more useful
 **/
class RenderNode extends Node<RenderNode> {
  public var viewDefinition : ViewDefinition;
  public var physicalBody : PhysicalBody;

  public var displayObject(default, default) : DisplayObject;
}