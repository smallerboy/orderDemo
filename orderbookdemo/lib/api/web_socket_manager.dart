import 'dart:io';
class WebSocketManager {

  static const String socket_url = 'wss://feed.testnet.duedex.com/v1/feed';
  
  WebSocketManager._();

  static WebSocketManager _manager;

  factory WebSocketManager() {
    if(_manager == null){
      _manager = WebSocketManager._();
    }
    return _manager;
  }

  //init
  Future<WebSocket> initWebSocket() {
    Future<WebSocket> future = WebSocket.connect(socket_url);
    return future;

  }

  //close
  void closeSocket(WebSocket webSocket) {
    if(webSocket != null) {
      webSocket.close();
    }
  }

}