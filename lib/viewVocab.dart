import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplevocab/newWord.dart';

class viewFullVocab extends StatefulWidget{
  @override
  State<viewFullVocab> createState() => _viewFullVocabState();
}

class _viewFullVocabState extends State<viewFullVocab> {
  final box = Hive.box('box');


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
        body: ValueListenableBuilder(
          valueListenable: Hive.box('box').listenable(),
          builder: (BuildContext context, Box<dynamic> box, Widget? child) {
            if(box.values.isEmpty){
              return Center(
                child: Text("EMPTY"),
              );
            }
            return ListView.separated(
              itemCount: box.length,
              itemBuilder: (context, index) {
                dynamic meaning = box.getAt(index);
                dynamic word = box.keyAt(index);
                editWord ed = editWord(word);
                return ListTile(
                  contentPadding: EdgeInsets.all(4),
                  leading: Text("  ${index+1}",style: TextStyle(fontSize: 25),),
                  title: Text("$word"),
                  trailing: Text("Click for Meaning", style: TextStyle(color: Colors.grey),),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context){
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title: Text("$word"),
                              content: Text("$meaning"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
                                TextButton(onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                    builder: (context) => newWordAdd(wordReceivedForEdit : ed.wordForEdit)
                                    )
                          )
                                ,child: Text("Edit"),)
                              ],
                            ),
                          );
                        }
                    );
                  },

                );
              }, separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.black,); },
            );
          },  //builder

        )

    );
  }
}
class editWord {
  final wordForEdit;
  editWord(this.wordForEdit);
}

