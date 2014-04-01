package apg.ragdoll.server;

import sys.net.Socket;
import sys.net.Host;

import apg.ragdoll.server.states.WaitForPlayers;

class Main {
  public static function main() {
    var game : Game = new Game(1);
    game.setState(new WaitForPlayers());

    var s = new Socket();
    s.bind(new Host('localhost'), 9999);
    s.listen(1);
    while (game.needsPlayers()) {
      try {
        var clientConnection = s.accept();
        game.addPlayer(new Player(clientConnection));
      } catch (error : String) {
        trace(error);
      }
    }
  }
}