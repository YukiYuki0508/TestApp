import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Input"),
        ),
        body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Text("tesuto")])));
  }
}
