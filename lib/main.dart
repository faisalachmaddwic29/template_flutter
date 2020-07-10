import 'package:flutter/material.dart';
import 'package:template/utils/utils.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: colorPrimary,
        scaffoldBackgroundColor: colorBackground,
        backgroundColor: colorBackground,
        accentColor: colorSecondary,
        visualDensity: VisualDensity.compact,
        highlightColor: colorPrimaryDarken,
        hoverColor: colorPrimaryDarken,
        hintColor: colorPlaceholder,
        fontFamily: fontFamily,
      ),
      title: appTitle,
      home: Scaffold(
        body: SafeArea(
          child: RaisedButton(
            child: Text("TEST API"),
            onPressed: () {
              // ApiRepository().apiGet('users').then((value) async {
              //   print(value);
              // });
              ApiRepository().apiPost('/login', data: {
                "username": "faiz",
                "password": "faiz",
              }).then((value) {
                print(value);
                print("jalan");
              });
            },
          ),
        ),
      ),
    );
  }
}
