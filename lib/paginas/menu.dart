import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:two_ziko/main.dart';
import 'package:two_ziko/services/myGlobals.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuPageState();
  }
}

class MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isNightMode ? colorBlack : Colors.white,
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Column(children: <Widget>[
              Expanded(
                flex: 2,
                child: this.Header(),
              ),
              Expanded(
                flex: 8,
                child: this.Body(),
              ),
            ]),
          ),
          Expanded(
            flex: 1,
            child: this.BarraLat(),
          ),
        ],
      ),
    );
  }

  Widget BarraLat() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox.fromSize(
              size: Size(25, 16), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "DESIGN",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
        Expanded(
          child: SizedBox.fromSize(
              size: Size(20, 16), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "GRAPHIC DESIGN",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
        Expanded(
          child: SizedBox.fromSize(
              size: Size(20, 16), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "ARCHITECTURE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
        Expanded(
          child: SizedBox.fromSize(
              size: Size(20, 16), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "INTERIORS DESIGN",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
        Expanded(
          child: SizedBox.fromSize(
              size: Size(20, 16), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "FASHION & BEAUTY",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
        Expanded(
          child: SizedBox.fromSize(
              size: Size(20, 16), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "PHOTOGRAPHY",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
        Expanded(
          child: SizedBox.fromSize(
              size: Size(20, 30), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 40),
                child: OutlinedButton(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        "CINEMA",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorBlack : Colors.white,
                        ),
                      )),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    backgroundColor: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 12,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              )),
        ),
      ],
    );
  }

  Widget Header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox.fromSize(
              size: Size(50, 25), // button width and height
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border:
                      Border.all(color: isNightMode ? colorGreen : colorBlue),
                ),
                child: OutlinedButton(
                  child: Text('MENÚ'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                      fontSize: 13,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                    navigatorKey.currentState?.pop();
                  },
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(65, 25), // button width and height
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border:
                        Border.all(color: isNightMode ? colorGreen : colorBlue),
                    color: isNightMode ? colorGreen : colorBlue),
                child: OutlinedButton(
                  child: Text('LOG OUT'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorBlack : Colors.white,
                    textStyle: TextStyle(
                      fontSize: 13,
                      //fontStyle: FontStyle.italic
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                    FirebaseAuth.instance.signOut();
                    navigatorKey.currentState?.pushNamed('login');
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
        Image.asset(
          isNightMode
              ? 'assets/img/logo_verde.png'
              : 'assets/img/logo_azul.png',
          height: 50.0,
        ),
      ],
    );
  }

  Widget Body() {
    return Column(children: <Widget>[
      Expanded(
          child: Row(
        children: <Widget>[
          Expanded(
              child: MaterialButton(
            height: 1000,
            minWidth: 110.0,
            hoverColor: Colors.white,
            onPressed: () {
              print("hola");
              navigatorKey.currentState?.pushNamed('mainPage');
            },
            color: isNightMode ? colorBlack : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "HOME _________________________",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ))
              ],
            ),
          )),
          Expanded(
              child: MaterialButton(
            height: 1000,
            minWidth: 120.0,
            hoverColor: Colors.white,
            onPressed: () {
              print("hola");
              navigatorKey.currentState?.pushNamed('explore');
            },
            color: isNightMode ? colorBlack : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "EXPLORE ______________________",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ))
              ],
            ),
          )),
          Expanded(
              child: MaterialButton(
            height: 1000,
            minWidth: 120.0,
            hoverColor: Colors.white,
            onPressed: () {
              print("hola");
              navigatorKey.currentState?.pushNamed('notifications');
            },
            color: isNightMode ? colorBlack : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "NOTIFICATIONS _______________",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ))
              ],
            ),
          )),
          Expanded(
              child: MaterialButton(
            height: 1000,
            minWidth: 120.0,
            hoverColor: Colors.white,
            onPressed: () {
              print("hola");
              navigatorKey.currentState?.pushNamed('profile');
            },
            color: isNightMode ? colorBlack : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "PFORILE _______________________",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ))
              ],
            ),
          )),
          Expanded(
              child: MaterialButton(
            height: 1000,
            minWidth: 120.0,
            hoverColor: Colors.white,
            onPressed: () {
              print("hola");
              navigatorKey.currentState?.pushNamed('curatedBy');
            },
            color: isNightMode ? colorBlack : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "CURATED BY ___________________",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ))
              ],
            ),
          )),
        ],
      ))
    ]);
  }
}
