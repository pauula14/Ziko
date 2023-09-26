import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/models/Article.dart';
import 'package:two_ziko/paginas/actualArticle.dart';
import 'package:two_ziko/paginas/user_profile.dart';
import 'package:two_ziko/services/myGlobals.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CuratedBy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CuratedByState();
  }
}

class CuratedByState extends State<CuratedBy> {
  _launchLink(String link) async {
    if (await canLaunchUrlString(link)) {
      await launchUrlString(link);
    } else {
      throw 'could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return Scaffold(
            backgroundColor: isNightMode ? colorBlack : Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Column(children: <Widget>[
                    Expanded(flex: 1, child: this.ExploraNavBar()),
                    Expanded(flex: 9, child: this.ExploraBody()),
                  ]),
                ),
              ],
            ));
      },
      //: getArticles(),
    );
  }

  Widget ExploraNavBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isNightMode ? colorGreen : colorBlue,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: [
            SizedBox.fromSize(
              size: Size(60, 30), // button width and height
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: OutlinedButton(
                  child: Text('MENÚ'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 14,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                    navigatorKey.currentState?.pushNamed('menu');
                  },
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(60, 30), // button width and height
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: OutlinedButton(
                  child: Text('MODE'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorGreen : colorBlue,
                    backgroundColor: isNightMode ? colorBlack : Colors.white,
                    textStyle: TextStyle(
                      fontSize: 14,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    isNightMode = !isNightMode;
                    setState(() {});
                  },
                ),
              ),
            )
          ]),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: Image.asset(
              isNightMode
                  ? 'assets/img/logo_verde.png'
                  : 'assets/img/logo_azul.png',
              height: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget ExploraBody() {
    return ListView(padding: EdgeInsets.zero, children: [
      Column(
        children: <Widget>[
          columnType1(),
          Span(),
          columnType2(),
          Span(),
          columnType3(),
          Span(),
          columnType4(),
          Span(),
        ],
      )
    ]);
  }

  Widget columnType1() {
    return Row(children: <Widget>[
      Expanded(
          flex: 4,
          child: Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: isNightMode ? colorGreen : colorBlue,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/img/curatedBy/juanVg.jpeg',
                        height: 120.0,
                        width: 120.0,
                      )),
                  SizedBox.fromSize(
                    size: Size(100, 25), // button width and height
                    child: Container(
                      //margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('JUAN VG'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorGreen : colorBlue,
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: 150,
                      margin: const EdgeInsets.only(
                          left: 5, right: 10, top: 10, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Fashion designer. Upcycling",
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: isNightMode ? colorGreen : colorBlue,
                        ),
                      )),
                ],
              ))),
      Expanded(
          flex: 7,
          child: Column(children: <Widget>[
            //color: isNightMode ? colorBlack : Colors.white,
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    //navigatorKey.currentState?.pushNamed('mainPage');
                    _launchLink(
                        "https://www.pusspussmagazine.com/wool-gang-friends-earth-announce-heal-wool-collaboration/");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "PUSS PUSS",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 7,
                          child: Container(
                              margin: EdgeInsets.only(left: 5, top: 10),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Wool and the Gang & Friends of the earth announce the Heal the Wool Collaboration",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://vman.com/article/prada-and-miu-miu-design-for-elvis/");
                  },
                  child: Stack(children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 5, left: 5),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "PRADA AND MIU MIU DESIGN FOR ELVIS",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "DAZED",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )),
                  ]),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://i-d.vice.com/en_uk/article/n7nax7/dior-mens-ss23-review");
                  },
                  child: Stack(children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 5, left: 70),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Dior Men's taps ERL for a celebration of californian cod",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "I-D UK",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )),
                  ]),
                )),
            Container(
                child: MaterialButton(
              onPressed: () {
                print("hola");
                _launchLink("https://www.pusspussmagazine.com/adidas-x-gucci/");
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "PUSS PUSS",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                  Expanded(
                      flex: 5,
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "ADIDAS X GUCCI",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                ],
              ),
            )),
          ]))
    ]);
  }

  Widget columnType2() {
    return Row(children: <Widget>[
      Expanded(
          flex: 6,
          child: Column(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://i-d.vice.com/en_uk/article/m7vmqv/donni-davy-interview-a24-half-magic-beauty-euphoria");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(right: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "I-D UK",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 7,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Euphoria makeup artist Donni Davy on the launch of her own beauty line",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://crfashionbook.com/why-marilyn-monroe-is-having-a-moment-in-2022/");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 4,
                          child: Container(
                              margin: EdgeInsets.only(right: 1),
                              //alignment: Alignment.bottomLeft,
                              child: Text(
                                "CR BOOK",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 6,
                          child: Container(
                              margin:
                                  EdgeInsets.only(left: 5, bottom: 5, top: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Why Marilyn is having a moment in 2022?",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://i-d.vice.com/en_uk/article/88gpab/k-pop-hair-stylists");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "I-D UK",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 7,
                          child: Container(
                              margin:
                                  EdgeInsets.only(left: 5, bottom: 5, top: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Meet the hairstylist working with your fave K-pop idols",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                child: MaterialButton(
              onPressed: () {
                print("hola");
                _launchLink(
                    "https://www.dazeddigital.com/beauty/head/article/56128/1/thank-god-for-gucci-and-its-trowelled-on-cosmogonie-make-up");
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                          margin: EdgeInsets.only(top: 5, left: 1),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "DAZED",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                  Expanded(
                      flex: 6,
                      child: Container(
                          margin: EdgeInsets.only(right: 5, top: 15),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "THANK GOD FOR GUCCI",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                ],
              ),
            )),
          ])),
      Expanded(
          flex: 4,
          child: Container(
              width: 180,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isNightMode ? colorGreen : colorBlue,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/img/curatedBy/nono.jpeg',
                        height: 120.0,
                        width: 130.0,
                      )),
                  SizedBox.fromSize(
                    size: Size(150, 25), // button width and height
                    child: Container(
                      //alignment: Alignment.centerRight,
                      //margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('NONO VÁZQUEZ'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorGreen : colorBlue,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: 150,
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Fashion director at Icon Stylist.",
                        maxLines: 4,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: isNightMode ? colorGreen : colorBlue,
                        ),
                      )),
                ],
              ))),
    ]);
  }

  Widget columnType3() {
    return Row(children: <Widget>[
      Expanded(
          flex: 4,
          child: Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: isNightMode ? colorGreen : colorBlue,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/img/curatedBy/pepa.jpeg',
                        height: 120.0,
                        width: 120.0,
                      )),
                  SizedBox.fromSize(
                    size: Size(135, 25), // button width and height
                    child: Container(
                      //margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('PEPA SALAZAR'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorGreen : colorBlue,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: 150,
                      margin: const EdgeInsets.only(
                          left: 15, right: 10, top: 10, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Fashion designer",
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: isNightMode ? colorGreen : colorBlue,
                        ),
                      )),
                ],
              ))),
      Expanded(
          flex: 6,
          child: Column(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://www.apartamentomagazine.com/stories/carlota-guerrero/");
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 5, top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "APARTAMENTO",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              left: 7, right: 5, top: 30, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "CARLOTA GUERRERO",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          )),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://vmagazine.com/article/mm6-maison-margiela-presents-an-unconventional-ode-to-nightlife/");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "V MAG",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 7,
                          child: Container(
                              margin:
                                  EdgeInsets.only(left: 5, bottom: 5, top: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "MM6 MAISON MARGIELA PRESENTS AN UNCONVENTIONAL ODE...",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://crfashionbook.com/15-fabulous-fashion-documentaries-to-watch-now/");
                  },
                  child: Stack(children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 5, left: 70, right: 5),
                        alignment: Alignment.topRight,
                        child: Text(
                          "15 fabulous fashion documentary",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CR BOOK",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )),
                  ]),
                )),
            Container(
                child: MaterialButton(
              onPressed: () {
                print("hola");
                _launchLink(
                    "https://www.anothermag.com/fashion-beauty/14054/this-is-how-sustainable-fashion-will-look-in-2022");
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                          margin: EdgeInsets.only(),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "ANOTHER",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                  Expanded(
                      flex: 6,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 5, left: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "This Is How Sustainable Fashion Will Look In 2022",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                ],
              ),
            )),
          ]))
    ]);
  }

  Widget columnType4() {
    return Row(children: <Widget>[
      Expanded(
          flex: 6,
          child: Column(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://es.newwavemagazine.com/photography-1/helena-milena");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Container(
                              //margin: EdgeInsets.only(bottom: 10, top: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "NEW WAVE",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              //margin: EdgeInsets.only(bottom: 5, top: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Bushy x All Saints",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://www.anothermag.com/art-photography/14130/yushi-li-photographer-staging-sexual-fantasies-using-tinder-dates-baron-books");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Container(
                              //margin: EdgeInsets.only(left: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "ANOTHER",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 5, top: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "The Photographer Staging Her Own Sexual Fantasies...",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isNightMode ? colorGreen : colorBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print("hola");
                    _launchLink(
                        "https://www.newwavemagazine.com/fashion-editorials-8/multiple-identities");
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              //margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "NEW WAVE",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              margin:
                                  EdgeInsets.only(left: 5, bottom: 5, top: 5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "MULTIPLE IDENTITIES",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isNightMode ? colorGreen : colorBlue,
                                ),
                              ))),
                    ],
                  ),
                )),
            Container(
                child: MaterialButton(
              onPressed: () {
                print("hola");
                _launchLink(
                    "https://www.dazeddigital.com/beauty/head/article/56128/1/thank-god-for-gucci-and-its-trowelled-on-cosmogonie-make-up");
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "DAZED",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                  Expanded(
                      flex: 6,
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "THANK GOD FOR GUCCI",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ))),
                ],
              ),
            )),
          ])),
      Expanded(
          flex: 4,
          child: Container(
              width: 180,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isNightMode ? colorGreen : colorBlue,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/img/curatedBy/isaGreece.jpeg',
                        height: 120.0,
                        width: 130.0,
                      )),
                  SizedBox.fromSize(
                    size: Size(150, 25), // button width and height
                    child: Container(
                      //alignment: Alignment.centerRight,
                      //margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('ISA GREECE'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorGreen : colorBlue,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: 150,
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Fashion stylist.",
                        maxLines: 4,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: isNightMode ? colorGreen : colorBlue,
                        ),
                      )),
                ],
              ))),
    ]);
  }

  Widget Span() {
    return Row(children: [
      Expanded(
          child: Container(
              height: 40,
              color: isNightMode ? colorGreen : colorBlue,
              alignment: Alignment.center,
              child: Text(
                "PODCAST EPISODE <3 <3",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: isNightMode ? colorBlue : colorGreen,
                ),
              )))
    ]);
  }
}
