import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key, this.uid}) : super(key: key);
  final String uid;
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
            child: Text('ログインして登録画面へ'),
            onPressed: () => pushButton(context),
          )
        ])));
  }
}
