import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:keyboard_actions/keyboard_actions.dart';

class searchWeb extends StatefulWidget {
  final wordToSearch;
  final box;
  const searchWeb({super.key, this.wordToSearch, this.box});

  @override
  State<searchWeb> createState() => _searchWebState();
}

class _searchWebState extends State<searchWeb> {
  final controller = TextEditingController();
  final FocusNode _nodeText2 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }
        ]),

      ],
    );
  }

  Future<void> fetchData() async{
    final obj = Api();
    final a = await obj.searchWebApi(widget.wordToSearch);
    controller.text = a;
    setState(() {});
  }
  Future Loading() async{
    await fetchData();
  }

  @override
  void initState()
  {
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((_) async {
       showDialog(
         barrierDismissible: false,
         builder: (ctx) {
           return Center(
             child: CircularProgressIndicator(
               strokeWidth: 2,
             ),
           );
         },
         context: context,
       );
       await Loading();
       Navigator.of(context).pop();
     });
    //fetchData();


  }


  write(key,value) async{
    if(key.isEmpty==false && value.isEmpty==false)
    {
      await widget.box.put(key,value);
      setState(() {});
      Fluttertoast.showToast(msg: "Wrote: $key",toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset : false, // to prevent overflow stuff
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text("Web Search", style: TextStyle(
                fontFamily: "Inter", letterSpacing: 2),),
            backgroundColor: Colors.grey[850],
          ),

          body: KeyboardActions(
            config: _buildConfig(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                      padding: EdgeInsets.all(40),
                      child: Text("${widget.wordToSearch}", style: TextStyle(fontSize: 30),)

                  ),
                ),

                // textfield for inputting meaning
                Container(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    focusNode: _nodeText2,

                    controller: controller,
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
                          write(widget.wordToSearch,controller.text);
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

                //just the back button
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
            ),
          ),

      ),
    );
  }
}

class Api extends searchWeb {
  searchWebApi(final word) async
  {
    final result = await http.get(
        Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
    if(result.statusCode==200){
      List jsonData = jsonDecode(result.body);
      String definitionsReturn = "";

      for (var entry in jsonData) {
        for (var meaning in entry['meanings']) {
          for (var definition in meaning['definitions']) {
            definitionsReturn += '- ${definition['definition']}\n';
          }
        }
      }
      return definitionsReturn;
    }
    else{
      return "Failed to Retrieve from Internet";
    }
  }

}
