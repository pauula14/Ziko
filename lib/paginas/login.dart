import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:two_ziko/main.dart';

//import 'package:two_ziko/data/user.dart';
//import 'package:two_ziko/data/user_dao.dart';
import 'package:two_ziko/services/database.dart';
//import 'package:two_ziko/user_bloc/user_state.dart';
//import 'package:two_ziko/data/app_database.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  List _users = [];
  String email;
  String password;

  void Pruebas() {
    DatabaseReference _testRef =
        // ignore: deprecated_member_use
        FirebaseDatabase(
                databaseURL:
                    "https://zikoapp-9d828-default-rtdb.europe-west1.firebasedatabase.app")
            .reference()
            .child("test");
    _testRef.set("Hola");
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String incorrectLogin = "";
  bool userExists = false;

  //PARA CERRAR SESION FirebaseAuth.instance.signOut();
  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      incorrectLogin = e.message;
    }

    navigatorKey.currentState.popUntil((route) => route.isFirst);

    //print("hola");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(child: this.LoginContent()),
          ],
        ));
  }

  Widget LoginContent() {
    return Container(
        decoration: BoxDecoration(color: Color(0xff6671d1)),
        child: Row(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, right: 30),
                    child: Image.asset(
                      'assets/img/logo_verde.png',
                      width: 380.0,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 30.0, right: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Empowering ",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w300,
                                color: Color(0xffD9FF28),
                              ),
                            )
                          ])),
                  Container(
                      margin: const EdgeInsets.only(top: 0.0, right: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "creativity ",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffD9FF28),
                              ),
                            ),
                            Text(
                              "by ",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w300,
                                color: Color(0xffD9FF28),
                              ),
                            )
                          ])),
                  Container(
                      margin: const EdgeInsets.only(top: 0.0, right: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "community ",
                              style: TextStyle(
                                fontSize: 50,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffD9FF28),
                              ),
                            )
                          ])),
                  Container(
                      margin: const EdgeInsets.only(top: 0.0, left: 130),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "<3 ",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w300,
                                color: Color(0xffD9FF28),
                              ),
                            )
                          ])),
                  Container(
                      margin: const EdgeInsets.only(top: 0.0, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox.fromSize(
                              size: Size(300, 40), // button width and height
                              child: Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: OutlinedButton(
                                  child: Text('CREATE ACCOUNT'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    primary: Color(0xff6671d1),
                                    backgroundColor: Color(0xffD9FF28),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  onPressed: () {
                                    navigatorKey.currentState
                                        ?.pushNamed('register');

                                    //loadUsers();
                                    //Pruebas();
                                  },
                                ),
                              ),
                            ),
                          ])),
                  Container(
                      margin: const EdgeInsets.only(top: 40.0, left: 100),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffD9FF28),
                              ),
                            )
                          ])),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 20.0, left: 100, right: 80),
                    width: 80,
                    height: 50,
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffD9FF28)),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffD9FF28), width: 2.3),
                          ),
                          hintText: 'EMAIL',
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD9FF28))),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10.0, left: 100, right: 80),
                    width: 180,
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffD9FF28)),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffD9FF28), width: 2.3),
                          ),
                          hintText: 'PASSWORD',
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD9FF28))),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 100),
                      child: Align(
                          child: Text(
                        incorrectLogin,
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffD9FF28),
                        ),
                      ))),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10.0, left: 100, bottom: 40),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox.fromSize(
                              size: Size(120, 40), // button width and height
                              child: Container(
                                child: OutlinedButton(
                                  child: Text('ENTER'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    primary: Color(0xff6671d1),
                                    backgroundColor: Color(0xffD9FF28),
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  onPressed: () {
                                    String emailInput = emailController.text;
                                    String passwordInput =
                                        passwordController.text;

                                    if (emailInput.isEmpty ||
                                        passwordInput.isEmpty) {
                                      incorrectLogin = "Some fields are empty!";
                                    } else {
                                      signIn();
                                    }

                                    setState(() {});

                                    /*
                                    email = emailController.text;
                                    password = passwordController.text;

                                    //readJson();

                                    int id = SearchUser(email);

                                    if (email != "" && password != "") {
                                      if ((id > -1) &&
                                          (_users[id]["password"] ==
                                              password)) {
                                        incorrectLogin = "";
                                        print("siguiente pagina");
                                        navigatorKey.currentState
                                            ?.pushNamed('mainPage');
                                      } else {
                                        incorrectLogin =
                                            "Password or username incorrect :(";
                                      }
                                    } else {
                                      incorrectLogin = "Some fields are empty!";
                                    }
                                    signIn;*/
                                  },
                                ),
                              ),
                            ),
                          ])),
                ],
              ),
            )
          ],
        ));
  }
}
