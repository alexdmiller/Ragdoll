package apg.net;

import neko.vm.Lock;
import neko.vm.Thread;

class MessageThread {
  private var messages : Array<MessageSocket.Message>;
  private var messagesLock : Lock;
  private var socket : MessageSocket;
  private var thread : Thread;
  private var run : Bool;

  public function new(socket : MessageSocket) {
    this.socket = socket;
    messagesLock = new Lock();
    messages = new Array<MessageSocket.Message>();
    messagesLock.release();
  }

  public function start() {
    trace("Starting thread.");
    this.run = true;
    this.thread = Thread.create(listenForMessages);
  }

  public function stop() {
    this.run = false;
  }

  public function hasMessage() : Bool {
    return messages.length != 0;
  }

  public function popMessage() : MessageSocket.Message {
    var acquired : Bool = messagesLock.wait(10000);
    if (acquired) {
      var message = messages.pop();
      messagesLock.release();
      return message;
    } else {
      throw "Waited too long for message thread lock.";
    }
  }

  private function listenForMessages() : Void {
    trace("Thread started.");
    while (this.run) {
      trace("Waiting for message.");
      var message : MessageSocket.Message = socket.recieve();
      var acquired : Bool = messagesLock.wait(10000);
      if (acquired) {
        trace("Got message. Adding to messages queue.");
        messages.unshift(message);
        messagesLock.release();
      } else {
        throw "Waited too long for message thread lock.";
      }
    }
  }
}