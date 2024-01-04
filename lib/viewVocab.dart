import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplevocab/ad_helper.dart';

class viewFullVocab extends StatefulWidget{
  @override
  State<viewFullVocab> createState() => _viewFullVocabState();
}

class _viewFullVocabState extends State<viewFullVocab> {
  final box = Hive.box('box');
  BannerAd? _banner;

  @override
  void initState(){
    super.initState();
    _createBannerAd();
  }
  void _createBannerAd(){
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId,
        listener: AdMobService.bannerListener,
        request: const AdRequest()
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Click Word for meaning", style: TextStyle(
              fontFamily: "Inter", letterSpacing: 1),),
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
                return ListTile(
                  contentPadding: EdgeInsets.all(4),
                  leading: Text("  ${index+1}",style: TextStyle(fontSize: 25),),
                  title: Text("$word"),
                  trailing: IconButton(onPressed: () {
                    showDialog(context: context, builder: (context){
                       return AlertDialog(title: Text("Are you Sure?"), content: Text("Delete this Word?"), actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text("No")),
                        TextButton(onPressed: () => {box.deleteAt(index),Navigator.pop(context)}, child: Text("Yes"))
                      ],);
                    });
                    setState(() {});
                  }, icon: Icon(Icons.delete_forever)),
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

        ),
        bottomNavigationBar: _banner==null
            ? Container()
            : Container(
          //margin: const EdgeInsets.only(bottom: 12),
          height: 52,
          child: AdWidget(ad: _banner!),
        )

    );
  }
}


