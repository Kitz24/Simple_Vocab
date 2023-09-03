import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class newWordAdd extends StatefulWidget {
  const newWordAdd({super.key});

  @override
  State<newWordAdd> createState() => _newWordAddState();
}

class _newWordAddState extends State<newWordAdd> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false, // to prevent overflow stuff
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("New Word", style: TextStyle(
              fontFamily: "Inter", letterSpacing: 2),),
          backgroundColor: Colors.grey[850],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),

            //First textfield for inputting word
            Container(
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                  hintText: "Enter a Word"
                ),
              ),
              padding: EdgeInsets.all(20),
            ),

            //Second textfield for inputting meaning
            Container(
              child: TextField(
                controller: _controller2,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    hintText: "Enter Word Meaning",
                ),
                maxLines: 10,
              ),
              padding: EdgeInsets.all(20),
            ),
            SizedBox(height:10),

            Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    splashColor: Colors.blue[100],
                    onTap: () {},
                    child: Container(
                        height: 50,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,color: Colors.white),
                            Text(
                              " Add Word",
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

            SizedBox(height: 10),

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