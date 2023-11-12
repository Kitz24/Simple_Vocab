import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class randomWord extends StatefulWidget {
  const randomWord({super.key});

  @override
  State<randomWord> createState() => _randomWordState();
}

class _randomWordState extends State<randomWord> {
  final box = Hive.box('box');

  checking()
  {
    if(box.values.isNotEmpty){
      Random random = new Random();
      int randomIndex = random.nextInt(box.length);
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  padding: EdgeInsets.all(40),
                  child: Text("${box.keyAt(randomIndex)}", style: TextStyle(fontSize: 30),)

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text("${box.getAt(randomIndex)}", style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      );
    }
    else{
      return Center(child:Text("EMPTY"));
    }
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Random Word", style: TextStyle(
              fontFamily: "Inter", letterSpacing: 2),),
          backgroundColor: Colors.grey[850],
        ),

        body: checking()

    );
  }
}
