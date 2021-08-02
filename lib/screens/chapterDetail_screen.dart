import 'dart:convert';
import 'package:book_app/screens/chapter_screen.dart';
import 'package:book_app/screens/details_screen.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:book_app/consttants.dart';

String plantNameID;

// ignore: must_be_immutable
class ChapterDetailsScreen extends StatefulWidget {
  String plantID;
  ChapterDetailsScreen({@required this.plantID});
  @override
  _ChapterDetailsScreenState createState() => _ChapterDetailsScreenState();
}

class _ChapterDetailsScreenState extends State<ChapterDetailsScreen> {
  bool _loaded = false;
  List _items = [];
  List<String> litems = [
    "Chapter1",
    "Chapter2",
    "Chapter3",
    "Chapter4",
    "Chapter5",
    "Chapter6",
    "Chapter7",
    "Chapter8",
    "Chapter9",
    "Chapter10"
  ];
  final TextEditingController eCtrl = new TextEditingController();
  int colorShade = 100;
  var unescape = HtmlUnescape();

  // Fetch content from the json file
  Future<void> loadChapter() async {
    String plantID = widget.plantID;
    final String response =
        await rootBundle.loadString("assets/json/thp/operation/chapter1.json");
    print("inside chapter class");
    print(response);
    final data = json.decode(response);
    _items = data["chapters"];
  }

  @override
  void initState() {
    super.initState();
    loadChapter().then((s) => setState(() {
          _loaded = true;
          print("inside init funtion chapter class");
        }));
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailsScreen(plantID: plantNameID);
                  },
                ),
              );
            },
          ),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
                child: new ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: litems.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return ChapterCardSubTopic(
                        name: "Operation Manual",
                        chapterNumber: 1,
                        tag: "Operation Manual",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChapterScreen();
                              },
                            ),
                          );
                        },
                      );
                    }))
          ],
        ));
  }
}

class ChapterCardSubTopic extends StatelessWidget {
  final String name;
  final String tag;
  final int chapterNumber;
  final Function press;
  const ChapterCardSubTopic({
    Key key,
    this.name,
    this.tag,
    this.chapterNumber,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      margin: EdgeInsets.only(bottom: 10),
      width: size.width - 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Chapter $chapterNumber : $name \n",
                  style: TextStyle(
                    fontSize: 16,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: tag,
                  style: TextStyle(color: kLightBlackColor),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onPressed: press,
          )
        ],
      ),
    );
  }
}
