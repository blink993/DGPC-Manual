import 'dart:convert';
import 'package:book_app/screens/home_screen.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ChapterScreen extends StatefulWidget {
  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  bool _loaded = false;
  List _items = [];
  var unescape = HtmlUnescape();

  // Fetch content from the json file
  Future<void> loadChapter() async {
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          },
        ),
      ),
      body: _loaded
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg.png"),
                        repeat: ImageRepeat.repeat,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: size.height * .1),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: [
                              TextSpan(
                                  text: unescape
                                      .convert(_items[0]["description"]),
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : new Center(
              child: new CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
