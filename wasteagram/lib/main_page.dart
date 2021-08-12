import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool hasStuff = false;

  @override
  Widget build(BuildContext context) {
    if (hasStuff) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Column(children: [
        Expanded(child: ListView()),
        ElevatedButton(onPressed: onButtonPress, child: Icon(Icons.camera))
      ]);
    }
  }

  void onButtonPress() {}
}
