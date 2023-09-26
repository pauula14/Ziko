import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/models/Article.dart';
import 'package:two_ziko/paginas/actualArticle.dart';
import 'package:two_ziko/services/myGlobals.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationsPageState();
  }
}

class NotificationsPageState extends State<NotificationsPage> {
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
      Container(
          alignment: Alignment.center,
          height: 60.0,
          decoration: BoxDecoration(
            color: isNightMode ? colorGreen : colorBlue,
            border: Border(
              bottom: BorderSide(
                color: isNightMode ? colorBlack : Colors.white,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    print("@belengarciiia_ te ha seguido");
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "@belengarciiia_ te ha seguido",
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorBlack : Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
              ])),
      Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          color: isNightMode ? colorGreen : colorBlue,
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorBlack : Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            print("@belengarciiia_ te ha seguido");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Has leído 3 artículos de CR BOOK, cómprala!",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isNightMode ? colorBlack : Colors.white,
                ),
              )),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          color: isNightMode ? colorGreen : colorBlue,
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorBlack : Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            print("@belengarciiia_ te ha seguido");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "@belengarciiia_ te ha mencionado en un comentario",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isNightMode ? colorBlack : Colors.white,
                ),
              )),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          color: isNightMode ? colorGreen : colorBlue,
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorBlack : Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            print("@belengarciiia_ te ha seguido");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Has leído 3 artículos de Dazed Beauty, cómprala!",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isNightMode ? colorBlack : Colors.white,
                ),
              )),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          color: isNightMode ? colorGreen : colorBlue,
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorBlack : Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            print("@belengarciiia_ te ha seguido");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "@aitanagavalda te ha mencionado en un comentario",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isNightMode ? colorBlack : Colors.white,
                ),
              )),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          color: isNightMode ? colorGreen : colorBlue,
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorBlack : Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            print("@belengarciiia_ te ha seguido");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Has leído 3 artículos de PUSS PUSS, cómprala!",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isNightMode ? colorBlack : Colors.white,
                ),
              )),
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          color: isNightMode ? colorGreen : colorBlue,
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorBlack : Colors.white,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            print("@belengarciiia_ te ha seguido");
          },
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "@aitanagavalda te ha seguido!",
                maxLines: 4,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isNightMode ? colorBlack : Colors.white,
                ),
              )),
        ),
      ),
    ]);
  }
}
