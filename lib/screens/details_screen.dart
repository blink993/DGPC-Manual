import 'dart:convert';

import 'package:book_app/consttants.dart';
import 'package:book_app/screens/chapterDetail_screen.dart';
import 'package:book_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String plantNameID;

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  String plantID;
  DetailsScreen({@required this.plantID});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _loaded = false;
  List _items = [];

  // Fetch content from the json file
  Future<void> loadManual() async {
    final String response = await rootBundle.loadString("assets/json/thp.json");
    final data = json.decode(response);
    String plantID = widget.plantID;

    print("****************");
    print(plantID);
    print("****************");

    if (plantID == '1') {
      _items = data["THP"];
      plantNameID = "Tala Hydropower Plant";
      print("inside THP");
      print(_items);
    } else if (plantID == '2') {
      _items = data["CHP"];
      plantNameID = "Chukha Hydropower Plant";
      print("inside CHP");
    } else if (plantID == '3') {
      _items = data["KHP"];
      plantNameID = "Kurichu Hydropower Plant";
      print("inside KHP");
    } else if (plantID == '4') {
      _items = data["BHP"];
      plantNameID = "Basochu Hydropower Plant";
      print("inside BHP");
    }
  }

  @override
  void initState() {
    super.initState();
    loadManual().then((s) => setState(() {
          _loaded = true;
          print("inside init funtion");
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
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              top: size.height * .12,
                              left: size.width * .1,
                              right: size.width * .02),
                          height: size.height * .48,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/bg.png"),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          child: BookInfo(
                            size: size,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * .6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ChapterCard(
                              name: "Operation Manual",
                              //chapterNumber: 1,
                              tag: "Operation Manual",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ChapterDetailsScreen(
                                          plantID: plantNameID);
                                    },
                                  ),
                                );
                              },
                            ),
                            ChapterCard(
                              name: "Maintenance Manual",
                              chapterNumber: 2,
                              tag: "Operation Manual",
                              press: () {},
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
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

class ChapterCard extends StatelessWidget {
  final String name;
  final String tag;
  final int chapterNumber;
  final Function press;
  const ChapterCard({
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 16),
      width: size.width - 48,
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
                  //text: "Chapter $chapterNumber : $name \n",
                  text: " $name \n",
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

class BookInfo extends StatelessWidget {
  const BookInfo({
    Key key,
    this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Power Plant : ",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 28),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: this.size.height * .005),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "$plantNameID",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: this.size.width * .3,
                            padding:
                                EdgeInsets.only(top: this.size.height * .02),
                            child: Text(
                              "test data has been inserted here !!!!  ",
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 10,
                                color: kLightBlackColor,
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: this.size.height * .015),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Image.asset(
                  "assets/images/book-1.png",
                  height: double.infinity,
                  alignment: Alignment.topRight,
                  fit: BoxFit.fitWidth,
                ),
              )),
        ],
      ),
    );
  }
}
