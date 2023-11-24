import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:simplevocab/searchWeb.dart';

class newWordAdd extends StatefulWidget {
  final box;
  const newWordAdd({super.key, this.box});

  @override
  State<newWordAdd> createState() => _newWordAddState();
}

class _newWordAddState extends State<newWordAdd> {
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final text = "";
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[800],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _nodeText2, toolbarButtons: [
              (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "CLOSE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        ]),
        KeyboardActionsItem(focusNode: _nodeText1, toolbarButtons: [
              (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "CLOSE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        ]),

      ],
    );
  }

  write(key,value) async{
    if(key.isEmpty==false && value.isEmpty==false)
    {
      await widget.box.put(key,value);
      Read();
      Fluttertoast.showToast(msg: "Wrote: $key",toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else
    {
      Fluttertoast.showToast(msg: "Please Enter Word & Meaning",toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  searchViaWeb(key)
  {
    if(key.isEmpty==false)
    {
      setState(() {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => searchWeb(wordToSearch : _controller.text, box : widget.box)
            )
        );
      });
    }
    else{
      Fluttertoast.showToast(msg: "Please Enter Word to Search",toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Read()
  {
    _controller.clear();
    _controller2.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset : false, // to prevent overflow stuff
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text("New Word", style: TextStyle(
                fontFamily: "Inter", letterSpacing: 2),),
            backgroundColor: Colors.grey[850],
          ),

          body: KeyboardActions(
            config: _buildConfig(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                //First textfield for inputting word
                Container(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    focusNode: _nodeText1,

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
                    keyboardType: TextInputType.text,
                    focusNode: _nodeText2,

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

                //LOGIC FOR ADDING BUTTON
                Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                        splashColor: Colors.blue[100],
                        onTap: () {
                          write(_controller.text,_controller2.text);
                        },
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

                SizedBox(height:10),

                //SEARCHING FROM WEB FOR MEANING
                Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                        splashColor: Colors.blue[100],
                        onTap: () {
                          searchViaWeb(_controller.text);
                        },
                        child: Container(
                            height: 50,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.wifi,color: Colors.white),
                                Text(
                                  " Search Web Meaning",
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
                )


              ],
            ),
          )

      ),
    );
  }
}

