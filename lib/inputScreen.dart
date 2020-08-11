import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InputScreen extends StatefulWidget {
  InputScreen({Key key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  String _text;
  @override
  void initState() {
    super.initState();
  }

  onSave() {
    FirebaseAuth.instance.currentUser().then(((currentUser) => Firestore
            .instance
            .collection("users")
            .document(currentUser.uid)
            .collection("textData")
            .add({
          "text": _text,
          "createdAt": DateTime.now(),
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Input"),
        ),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  "テキスト",
                ),
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                    maxLines: 1,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    autofocus: false,
                    decoration: InputDecoration(
                      errorMaxLines: 4,
                      hintText: '22.0',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(0.0),
                        ),
                        borderSide: BorderSide(
                          width: 0.0,
                        ),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'テキストを入力してください';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      this._text = value.toString();
                      setState(() {
                        _text = this._text;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  elevation: 5.0,
                  child: Text("送信"),
                  // 送信ボタンクリック時の処理
                  onPressed: () {
                    // バリデーションチェック
                    if (_formKey.currentState.validate()) {
                      // バリデーションが通れば結果を表示
                      _formKey.currentState.save();
                      onSave();
                    }
                  },
                ),
              ),
            ],
          ),
        ])));
  }
}
