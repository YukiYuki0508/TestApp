import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './homeScreen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    nameInputController = new TextEditingController();
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
        title: Text("アカウント作成"),
      ),
      body: registerscreen(),
    );
  }

  Widget registerscreen() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
          key: _registerFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Name*', hintText: "Lebron"),
                controller: nameInputController,
                validator: (value) {
                  if (value.length < 3) {
                    return "名前は3文字以上で入力してください";
                  }
                },
              ),
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
                  "アカウント作成",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (_registerFormKey.currentState.validate()) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailInputController.text,
                            password: pwdInputController.text)
                        .then((currentUser) => Firestore.instance
                            .collection("users")
                            .document(currentUser.user.uid)
                            .setData({
                              "uid": currentUser.user.uid,
                              "name": nameInputController.text,
                              "email": emailInputController.text,
                            })
                            .then((result) => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                                uid: currentUser.user.uid,
                                              )),
                                      (_) => false),
                                  nameInputController.clear(),
                                  emailInputController.clear(),
                                  pwdInputController.clear(),
                                })
                            .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                  }
                },
              ),
              FlatButton(
                child: Text(
                  "ログイン",
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )));
  }
}
