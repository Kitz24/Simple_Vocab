import 'package:flutter/material.dart';

class viewFullVocab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("View Vocabulary", style: TextStyle(
              fontFamily: "Inter", letterSpacing: 2),),
          backgroundColor: Colors.grey[850],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Placeholder(fallbackHeight: 200,),
            SizedBox(height: 50),
            Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    splashColor: Colors.blue[100],
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(

                        height: 50,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back,color: Colors.white),
                            Text(
                              " Go back",
                              style: TextStyle(
                                  letterSpacing: 4,
                                  fontFamily: "Inter",
                                  color: Colors.white
                                  ,fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                    )
                )
            ),
          ],
        )

    );
  }

}