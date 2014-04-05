package apg.ragdoll.server;

import sys.net.Socket;
import sys.net.Host;
import neko.vm.Thread;

import apg.ragdoll.server.states.WaitForPlayers;

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
        var clientConnection : Socket = Thread.readMessage(true);
        gameServer.addPlayer(new PlayerConnection(clientConnection));
      } catch (error : String) {
        trace(error);
      }
    }
    parentThread.sendMessage(GameThreadState.DoesNotNeedConnections);
  }
}