package apg.ragdoll.server;

import sys.net.Socket;
import sys.net.Host;
import neko.vm.Thread;
import haxe.Unserializer;

import apg.net.MessageSocket;
import apg.net.HaxeMessageSocket;
import apg.ragdoll.server.states.WaitForPlayers;
import apg.ragdoll.messages.PlayerInfoMessage;


enum GameThreadState {
  NeedsConnections;
  DoesNotNeedConnections;
}

class Main {
  public static function main() {
    var s = new Socket();
    s.bind(new Host('localhost'), 9999);
    s.listen(1);
    while (true) {
      var gameThread = Thread.create(startNewGame);
      gameThread.sendMessage(Thread.current());
      while (Thread.readMessage(true) == GameThreadState.NeedsConnections) {
        var clientConnection = s.accept();
        gameThread.sendMessage(clientConnection);
      }
    }
  }

  private static function startNewGame() {
    var parentThread : Thread = Thread.readMessage(true);
    var gameServer : GameServer = new GameServer(1);
    gameServer.setState(new WaitForPlayers());
    while (gameServer.needsPlayers()) {
      parentThread.sendMessage(GameThreadState.NeedsConnections);
      try {
        var clientConnection : MessageSocket = new HaxeMessageSocket(Thread.readMessage(true));
        var playerInfo : PlayerInfoMessage = cast(clientConnection.recieve(), PlayerInfoMessage);
        gameServer.addPlayer(new PlayerConnection(clientConnection, playerInfo));
      } catch (error : String) {
        trace(error);
      }
    }
    parentThread.sendMessage(GameThreadState.DoesNotNeedConnections);
  }
}