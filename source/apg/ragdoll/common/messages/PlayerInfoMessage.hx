package apg.ragdoll.common.messages;

import apg.net.MessageSocket.Message;

class PlayerInfoMessage implements Message {
  public function new() { }
  public var name : String;

  public static function withName(name) : PlayerInfoMessage {
    var message = new PlayerInfoMessage();
    message.name = name;
    return message;
  }
}