import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './homeScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return '正しいEmailのフォーマットで入力してください';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ログイン"),
        ),
        body: loginscreen());
  }

  Widget loginscreen() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
          key: _loginFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Email*', hintText: "lebron.james@gmail.com"),
                controller: emailInputController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password*', hintText: "********"),
                controller: pwdInputController,
                obscureText: true,
                validator: pwdValidator,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              RaisedButton(
                child: Text(
                  "ログイン",
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (_loginFormKey.currentState.validate()) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailInputController.text,
                            password: pwdInputController.text)
                        .then((currentUser) => Firestore.instance
                            .collection("users")
                            .document(currentUser.user.uid)
                            .get()
                            .then((DocumentSnapshot result) =>
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                              uid: currentUser.user.uid,
                                            ))))
                            .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                  }
                },
              ),
              FlatButton(
                child: Text(
                  "アカウントを作成する",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
              )
            ],
          ),
        )));
  }
}
