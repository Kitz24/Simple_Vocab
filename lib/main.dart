 import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplevocab/newWord.dart';
import 'package:simplevocab/randomWord.dart';
import 'package:simplevocab/viewVocab.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('box');

  runApp(MaterialApp(
    home: Mainpage(),
    theme: ThemeData.dark(),
  ));
}
class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    final boxu = Hive.box('box');
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Simple Vocab", style: TextStyle(
          fontFamily: "Inter",
          letterSpacing: 2
        ),),
        backgroundColor: Colors.grey[850],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset('assets/simple_vocab.png'),
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue[100],
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => newWordAdd(box: boxu)
                    )
                );
              },
              child: Container(

                height: 50,
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mode_edit_sharp,color: Colors.white),
                    Text(
                      "Add Word",
                      style: TextStyle(
                        letterSpacing: 4,
                        fontFamily: "Inter",
                        color: Colors.white
                      ),
                    )
                  ],
                )
          )
            )
          ),
          SizedBox(height: 10,),
          Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => viewFullVocab()
                        )
                    );
                  },
                  child: Container(

                      height: 50,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book_rounded,color: Colors.white),
                          Text(
                            "View Vocabulary",
                            style: TextStyle(
                                letterSpacing: 4,
                                fontFamily: "Inter",
                                color: Colors.white
                            ),
                          )
                        ],
                      )
                  )
              )
          ),
          SizedBox(height: 10,),
          Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => randomWord()
                        )
                    );
                  },
                  child: Container(

                      height: 50,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.question_mark,color: Colors.white),
                          Text(
                            "Random Word",
                            style: TextStyle(
                                letterSpacing: 4,
                                fontFamily: "Inter",
                                color: Colors.white
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
