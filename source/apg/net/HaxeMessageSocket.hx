package apg.net;

import haxe.Serializer;
import haxe.Unserializer;

class HaxeMessageSocket implements MessageSocket {
  private var socket : sys.net.Socket;

  public function new(socket : sys.net.Socket) {
    this.socket = socket;
  }

  public function send(message : MessageSocket.Message) : Void {
    var messageString = Serializer.run(message);
    socket.write(messageString + '\n');
  }

  public function recieve() : MessageSocket.Message {
    var messageString = socket.input.readLine();
    var message : MessageSocket.Message = Unserializer.run(messageString);
    return message;
  }
}