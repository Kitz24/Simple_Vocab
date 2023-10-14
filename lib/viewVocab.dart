import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class viewFullVocab extends StatefulWidget{
  @override
  State<viewFullVocab> createState() => _viewFullVocabState();
}

class _viewFullVocabState extends State<viewFullVocab> {
  final box = Hive.box('box');

  void printing() async
  {
    print(box.keys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("View Vocabulary", style: TextStyle(
              fontFamily: "Inter", letterSpacing: 2),),
          backgroundColor: Colors.grey[850],
        ),

        // TODO attach database
        body: ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(4),
                leading: Icon(Icons.arrow_forward_outlined),
                title: Text("Word ${index+1}"),
                trailing: Text("Meaning", style: TextStyle(color: Colors.grey),),
                onTap: () {
                  printing();
                  Fluttertoast.showToast(msg: "Index $index",toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },

              );
            },
        )

    );
  }
}

