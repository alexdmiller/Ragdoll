package apg.ragdoll.server;

import sys.net.Socket;
import sys.net.Host;

class Main {
  public static function main() {
    var lastClient : Socket = null;

    var s = new Socket();
    s.bind(new Host('localhost'), 9999);
    s.listen(1);
    while (true) {
      var clientConnection = s.accept();
      if (lastClient != null) {
        var game = new Game([
          new Player(lastClient),
          new Player(clientConnection)
        ]);
        lastClient = null;
      } else {
        lastClient = clientConnection;
      }
    }
  }
}