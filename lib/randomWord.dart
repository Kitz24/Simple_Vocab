import 'package:flutter/material.dart';

class randomWord extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Random Word", style: TextStyle(
              fontFamily: "Inter", letterSpacing: 2),),
          backgroundColor: Colors.grey[850],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  padding: EdgeInsets.all(40),
                  child: Text("Placeholder", style: TextStyle(fontSize: 30),)

              ),
            ),
            Text("data", style: TextStyle(fontSize: 20),)
          ],
        )

    );
  }

}