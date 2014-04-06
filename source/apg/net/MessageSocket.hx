package apg.net;

interface MessageSocket {
  function send(message : Message) : Void;
  function recieve() : Message;
}

interface Message { }