import 'package:flutter/material.dart';

import 'broadcast.dart';
import 'receive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stateful'),
        ),
        body: Center(
          child: ClickGood(),
        ),
      ),
    );
  }
}

class ClickGood extends StatefulWidget {
  @override
  _ClickGoodState createState() => _ClickGoodState();
}

class _ClickGoodState extends State<ClickGood> {
  bool _broadcastActive = false;
  bool _receiveActive = false;

  var _broadcast = Broadcast();
  var _receive = Receive();

  void _broadcastTap() {
    if (!_receiveActive) {
      if (!_broadcastActive) {
        _broadcast.broadcastOn();
      } else {
        _broadcast.broadcastOff();
      }
      setState(
        () {
          _broadcastActive = !_broadcastActive;
        },
      );
    }
  }

  void _receiveTap() {
    if (!_broadcastActive) {
      if (!_receiveActive) {
        _receive.receiveOn();
      } else {
        _receive.receiveOff();
      }
      setState(
        () {
          _receiveActive = !_receiveActive;
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: FlatButton(
            onPressed: _broadcastTap,
            color: _broadcastActive ? Colors.orange[700] : Colors.grey[500],
            minWidth: 200.0,
            height: 50.0,
            child: Text(
              "発信",
              style: TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: FlatButton(
            onPressed: _receiveTap,
            color: _receiveActive ? Colors.orange[700] : Colors.grey[500],
            minWidth: 200.0,
            height: 50.0,
            child: Text(
              "検出",
              style: TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
