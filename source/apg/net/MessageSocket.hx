package apg.net;

interface MessageSocket {
  function send(message : Message) : Void;
  function recieve() : Message;
  function setBlocking(blocking : Bool) : Void;
}

interface Message { }