import 'dart:convert';

class WebSocketSubscribe {

  subscribeOrder() {
    return json.encode(_subscribeParams());
    //return _subscribeParams();
  }

  Map _subscribeParams() {
    return {
      "type": "subscribe",
      "channels": [
        {
          "name": "level2",
          "instruments": [
            "BTCUSD"
          ]
        }
      ]
    };
  }

}