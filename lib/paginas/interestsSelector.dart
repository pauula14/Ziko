import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sembast/sembast.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/services/database.dart';

class InterestsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InterestsPageState();
  }
}

class InterestsPageState extends State<InterestsPage> {
  final user = FirebaseAuth.instance.currentUser;
  List<bool> buttons = new List.filled(24, false);
  final allInterests = [
    'fashion',
    'art',
    'film',
    'culture',
    'environment',
    'beauty',
    'music',
    'editorials',
    'man',
    'series',
    'interiors',
    'architecture',
    'fashion weeks',
    'celebs',
    'tech',
    'new gen',
    'photography',
    'tv',
    'feminism',
    'lgtbiq',
    'shows',
    'conversations',
    'travel',
    'digital'
  ];
  List<String> interests = <String>[];

  List<String> setUserInterests() {
    for (int i = 0; i < allInterests.length; i++) {
      //if the interest is selected, it is added to the list of the user for the database
      if (buttons[i]) {
        interests.add(allInterests[i]);
      }
    }
    return interests;
  }

  Future setUserData() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    //Create new document dor the user with the uid
    await DatabaseService(uid: user.uid)
        .updateUserInterests(setUserInterests());

    //FirebaseFirestore.instance.collection('users').doc(user.uid);
    //.update({"userInterests": FieldValue.arrayUnion(allInterests)});
    //await DatabaseService(uid: user.uid)
    //  .update("users", FieldValue.arrayUnion(allInterests));

    navigatorKey.currentState?.pushNamed('step2_register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                this.TitlePage(),
                this.Explanation(),
                this.Selector(),
              ],
            ))
          ],
        ));
  }

  Widget TitlePage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 10, top: 40),
          child: Text(
            "STEP 1",
            style: TextStyle(
              fontSize: 60,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: Color(0xff6671D2),
            ),
          )),
    );
  }

  Widget Explanation() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
          child: Text(
            "Select your interests <3",
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w400,
              color: Color(0xff6671D2),
            ),
          )),
    );
  }

  Widget Selector() {
    return Expanded(
        child: ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 0
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(200, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('FASHION'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        enableFeedback: true,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[0]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[0] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        setState(() {});
                        buttons[0] = !buttons[0];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 1
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(100, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('ART'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[1]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[1] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[1] = !buttons[1];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 2
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(140, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('FILM'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[2]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[2] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[2] = !buttons[2];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 3
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(180, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('CULTURE'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[3]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[3] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[3] = !buttons[3];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 4
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(290, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('ENVIRONMENT'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[4]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[4] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[4] = !buttons[4];
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 5
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(190, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('BEAUTY'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[5]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[5] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[5] = !buttons[5];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 6
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(140, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('MUSIC'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[6]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[6] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[6] = !buttons[6];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 7
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(250, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('EDITORIALS'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[7]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[7] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[7] = !buttons[7];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 8
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(130, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('MAN'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[8]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[8] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[8] = !buttons[8];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 9
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(150, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('SERIES'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[9]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight:
                                buttons[9] ? FontWeight.w700 : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[9] = !buttons[9];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 10
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(230, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('INTERIORS'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[10]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[10]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[10] = !buttons[10];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 11
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(310, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('ARCHITECTURE'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[11]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[11]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[11] = !buttons[11];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 12
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(340, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('FASHION WEEKS'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[12]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[12]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[12] = !buttons[12];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 13
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(180, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('CELEBS'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[13]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[13]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[13] = !buttons[13];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 14
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(120, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('TECH'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[14]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[14]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[14] = !buttons[14];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 15
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(200, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('NEW GEN'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[15]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[15]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[15] = !buttons[15];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 16
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(310, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('PHOTOGRAPHY'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[16]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[16]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[16] = !buttons[16];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 17
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(100, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('TV'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[17]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[17]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[17] = !buttons[17];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 18
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(200, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('FEMINISM'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[18]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[18]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[18] = !buttons[18];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          //Boton 19
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(180, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('LGTBIQ'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[19]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[19]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[19] = !buttons[19];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 20
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(150, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('SHOWS'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[20]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[20]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[20] = !buttons[20];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 21
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(330, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('CONVERSATIONS'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[21]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[21]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[21] = !buttons[21];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, bottom: 20),
          height: 80,
          child: Row(
            children: <Widget>[
              Align(
                //Boton 22
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(180, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('TRAVEL'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[22]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[22]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[22] = !buttons[22];
                      },
                    ),
                  ),
                ),
              ),
              Align(
                //Boton 23
                alignment: Alignment.bottomLeft,
                child: SizedBox.fromSize(
                  size: Size(150, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xff6671D2)),
                    ),
                    child: OutlinedButton(
                      child: Text('DIGITAL'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Color(0xff6671D2),
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: buttons[23]
                                ? FontStyle.italic
                                : FontStyle.normal,
                            fontWeight: buttons[23]
                                ? FontWeight.w700
                                : FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setState(() {});
                        buttons[23] = !buttons[23];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 20, bottom: 40, right: 40, top: 20),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                //Boton 24
                child: SizedBox.fromSize(
                  size: Size(155, 60), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: OutlinedButton(
                      child: Text('NEXT ->'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        backgroundColor: Color(0xff6671D2),
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setUserData();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
