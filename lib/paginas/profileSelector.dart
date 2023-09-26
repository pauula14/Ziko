import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/models/UserZiko.dart';
import 'package:two_ziko/services/database.dart';

class ProfileSelectorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileSelectorPageState();
  }
}

class ProfileSelectorPageState extends State<ProfileSelectorPage> {
  final user = FirebaseAuth.instance.currentUser;
  UserZiko userData;

  final controllerOne = TextEditingController();
  final controllerTwo = TextEditingController();
  final controllerThree = TextEditingController();
  final controllerFour = TextEditingController();
  final nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var image;

  Future setUserData(
      String one, String two, String three, String four, String name) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    //Create new document dor the user with the uid
    await DatabaseService(uid: user.uid)
        .updateStep2(one, two, three, four, name);

    navigatorKey.currentState?.pushNamed('mainPage');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserZiko>(
        stream: DatabaseService(uid: user.uid).userDataStep2,
        builder: ((context, AsyncSnapshot<UserZiko> snapshot) {
          if (snapshot.hasData) {
            userData = snapshot.data;
            return (Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        this.TitlePage(),
                        this.Explanation(),
                        Expanded(child: this.BodySelector()),
                      ],
                    ))
                  ],
                )));
          }
          return Center(child: CircularProgressIndicator());
        }));
  }

  Widget TitlePage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 10, top: 40),
          child: Text(
            "STEP 2",
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
            "Edit your profile :)",
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w400,
              color: Color(0xff6671D2),
            ),
          )),
    );
  }

  Widget BodySelector() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "@${userData.username}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6671D2),
                          ),
                        ))))),
        Expanded(
            flex: 9,
            child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0xff6671D2),
                      width: 2.0,
                    ),
                  ),
                ),
                child: Expanded(
                    child: ListView(children: <Widget>[this.InfoFields()]))))
      ],
    );
  }

  Widget InfoFields() {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 0.0,
              left: 20,
            ),
            child: Image.asset(
              'assets/img/profileImage.png',
              height: 140.0,
              width: 100.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, bottom: 50),
            width: 160,
            height: 30,
            child: TextField(
              controller: nameController,
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6671d1)),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff6671d1), width: 1.5),
                  ),
                  hintText: 'Name',
                  contentPadding: EdgeInsets.all(8),
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6671d1))),
            ),
          ),
        ]),
        Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 20),
                    child: Text(
                      "BIO",
                      style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff6671D2),
                      ),
                    ))),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
              height: 40,
              child: TextField(
                controller: controllerOne,
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6671d1)),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff6671d1), width: 1.5),
                    ),
                    hintText: 'Interest 1',
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6671d1))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
              height: 40,
              child: TextField(
                controller: controllerTwo,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6671d1)),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff6671d1), width: 1.5),
                    ),
                    hintText: 'Interest 2',
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6671d1))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
              height: 40,
              child: TextField(
                controller: controllerThree,
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6671d1)),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff6671d1), width: 1.5),
                    ),
                    hintText: 'Interest 3',
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6671d1))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
              height: 40,
              child: TextField(
                controller: controllerFour,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6671d1)),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff6671d1), width: 1.5),
                    ),
                    hintText: 'Interest 4',
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6671d1))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 30, right: 20),
              alignment: Alignment.topRight,
              child: SizedBox.fromSize(
                  size: Size(120, 45), // button width and height
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: OutlinedButton(
                      child: Text('ENTER'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: Colors.white,
                        backgroundColor: Color(0xff6671d1),
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      onPressed: () {
                        print('Pressed');
                        setUserData(
                            controllerOne.text,
                            controllerTwo.text,
                            controllerThree.text,
                            controllerFour.text,
                            nameController.text);
                      },
                    ),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
