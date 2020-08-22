import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './homeScreen.dart';
import './inputScreen.dart';
import './loginScreen.dart';
import './registerScreen.dart';
import './rootScreen.dart';

void main() {
  runApp(MyApp());
}

const MaterialColor customSwatch = const MaterialColor(
  0xFF3f51b5,
  const <int, Color>{
    50: const Color(0xFFE8EAF6),
    100: const Color(0xFFC5CBE9),
    200: const Color(0xFF9FA8DA),
    300: const Color(0xFF7985CB),
    400: const Color(0xFF5C6BC0),
    500: const Color(0xFF3F51B5),
    600: const Color(0xFF394AAE),
    700: const Color(0xFF3140A5),
    800: const Color(0xFF29379D),
    900: const Color(0xFF1B278D),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Implementation App',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,

      home: RootScreen(),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
      // home: Onboarding(),
      // home: RootScreen(auth: Auth(), title: 'PFC assist'),
      routes: {
        '/onboard': (BuildContext context) => HomeScreen(),
        '/input': (BuildContext context) => InputScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) => RegisterScreen(),
      },
    );
  }
}
