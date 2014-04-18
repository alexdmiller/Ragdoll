package apg.ragdoll.nodes;

import flash.display.DisplayObject;

import ash.core.Node;
import nape.phys.Body;

import apg.ragdoll.components.ViewProperties;
import apg.ragdoll.components.Position;

class RenderNode extends Node<RenderNode> {
  public var viewProperties : ViewProperties;
  public var position : Position;

  public var displayObject(default, default) : DisplayObject;
}