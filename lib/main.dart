import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Mainpage(),
    theme: ThemeData.dark(),
  ));
}
class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Simple Vocab"),
        backgroundColor: Colors.grey[850],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Placeholder(fallbackHeight: 200,),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue[100],
              onTap: () {},
              child: Container(
                color: Colors.grey[900],
                height: 50,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mode_edit_sharp,color: Colors.white),
                    Text(
                      "Add Word",
                      style: TextStyle(
                        letterSpacing: 4,
                        fontFamily: "Pacifico",
                        color: Colors.white
                      ),
                    )
                  ],
                )
          )
            )
          )
        ],
      )
    );
  }
}
