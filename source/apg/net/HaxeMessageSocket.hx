package apg.net;

import haxe.Serializer;
import haxe.Unserializer;
import apg.net.MessageSocket.Message;

class HaxeMessageSocket implements MessageSocket {
  private var socket : sys.net.Socket;

  public function new(socket : sys.net.Socket) {
    this.socket = socket;
  }

  public function send(message : Message) : Void {
    var messageString = Serializer.run(message);
    socket.write(messageString + '\n');
  }

  public function recieve() : Message {
    var messageString = socket.input.readLine();
    var message : Message = Unserializer.run(messageString);
    return message;
  }
}