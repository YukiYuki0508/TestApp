import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  pushButton(context) {
    Navigator.of(context).pushNamed("/input");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          RaisedButton(
            child: Text('Input画面へ'),
            onPressed: () => pushButton(context),
          )
        ])));
  }
}
