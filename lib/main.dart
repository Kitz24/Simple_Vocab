import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Mainpage(),
  ));
}
class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Vocab"),
      ),
    );
  }
}
