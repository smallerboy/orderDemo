
import 'dart:async';
import 'dart:convert';
import 'package:orderbookdemo/blocs/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class OrderBookBloc implements BlocBase {

   BehaviorSubject<Map> _order = BehaviorSubject<Map>();

   Sink<Map> get _orderSink => _order.sink;
   Stream<Map> get orderStream => _order.stream;

   addOrder(order) {
     Map<String, dynamic> map = json.decode(order);
     List bids = map['data']['bids'];
     List asks = map['data']['asks'];

     _order.add({
       'symbols':map['instrument'],
       'asks':asks.first,
       'bids':bids.first
     });
   }

  // void addSubscribe(webSocket) {
  //   webSocket.add(WebSocketSubscribe().subscribeOrder());
  // }

  @override
  void dispose() {
    _orderSink.close();
  }

}