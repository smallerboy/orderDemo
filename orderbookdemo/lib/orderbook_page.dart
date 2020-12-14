import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderbookdemo/api/web_socket_manager.dart';
import 'package:orderbookdemo/api/web_socket_subscribe.dart';
import 'package:orderbookdemo/blocs/bloc_orderbook.dart';

class OrderBook extends StatefulWidget {

  @override
  OrderBookState createState() => new OrderBookState();
}

class OrderBookState extends State<OrderBook>{

  OrderBookBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = OrderBookBloc();
     WebSocketManager().initWebSocket()
         .then((webSocket) {
      addSubscribe(webSocket);
      webSocket.listen((onData) {
        bloc.addOrder(onData);
      },onError: (err) {
        print("服务端error"+err);
      },onDone: () {
        print("服务端done");
      });
    });

  }

  void addSubscribe(webSocket) {
    webSocket.add(WebSocketSubscribe().subscribeOrder());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.orderStream,
        builder:(BuildContext context, AsyncSnapshot<Map> snapshot) {
          return Scaffold(
              appBar: new AppBar(
                elevation: 0,
                centerTitle: true,
                title: new Text('orderBookDemo'),
              ),
            body: _buildOrderBody(snapshot.data),
          );
        }
    );
  }
  
  Widget _buildOrderBody(Map orderMap) {

    if(orderMap == null) {
      return Text('loading!');
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          _buildBidsItem(orderMap['bids'].toString()),
          _buildAsksItem(orderMap['asks'].toString())
        ],
      ),
    );
  }

  Widget _buildBidsItem(String bidsString) {

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 40),
        height: 55,
        color: Colors.red,
        child: Row(
          children: [
            Text(bidsString),
          ],
        ),
      ),
    );
  }

  Widget _buildAsksItem(String asksString) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 40),
          height: 55,
          color: Colors.green,
          child: Row(
            children: [
              Text(asksString),
            ],
          ),
        )
    );
  }
}