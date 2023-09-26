import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/services/database.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountPageState();
  }
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  String incorrectSignUp = "";
  bool validEmail = false;

  Future signUp() async {
    final isValid = formKey.currentState.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User user = result.user;

      //Create new document dor the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
          user.email,
          firstNameController.text,
          lastNameController.text,
          usernameController.text);

      navigatorKey.currentState?.pushNamed('step1_register');
      //Navigator.of(context).popUntil((route) => route.settings.name == "step1_register");
      //navigatorKey.currentState.popUntil(ModalRoute.withName('step1_register'));
    } on FirebaseAuthException catch (e) {
      print(e);
      incorrectSignUp = e.message;
      navigatorKey.currentState.popUntil(ModalRoute.withName('register'));
      navigatorKey.currentState.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(child: this.CreateAccountContent()),
          ],
        ));
  }

  Widget CreateAccountContent() {
    return Form(
        key: formKey,
        child: Container(
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
                          margin: const EdgeInsets.only(top: 30.0, right: 25),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "NEW ACCOUNT ",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffD9FF28),
                                  ),
                                )
                              ])),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 30.0, left: 70, right: 30),
                        width: 80,
                        height: 50,
                        child: TextField(
                          controller: firstNameController,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD9FF28)),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffD9FF28), width: 2.3),
                              ),
                              hintText: 'FIRST NAME',
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffD9FF28))),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 70, right: 30),
                        width: 180,
                        height: 50,
                        child: TextField(
                          controller: lastNameController,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD9FF28)),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffD9FF28), width: 2.3),
                              ),
                              hintText: 'LAST NAME',
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffD9FF28))),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 70, right: 30),
                        width: 180,
                        height: 50,
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
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
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 70, right: 30),
                        width: 180,
                        height: 50,
                        child: TextField(
                          controller: usernameController,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD9FF28)),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffD9FF28), width: 2.3),
                              ),
                              hintText: 'USERNAME',
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffD9FF28))),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 70, right: 30),
                        width: 180,
                        height: 50,
                        child: TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? "Enter min. 6 characters"
                                  : null,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD9FF28)),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
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
                          margin: const EdgeInsets.only(top: 10, left: 70),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  incorrectSignUp,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffD9FF28),
                                  ),
                                )
                              ])),
                      Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 70, bottom: 40),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox.fromSize(
                                  size:
                                      Size(120, 40), // button width and height
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
                                        print('Pressed');

                                        String fName = firstNameController.text;
                                        String lName = lastNameController.text;
                                        String email = emailController.text;
                                        String username =
                                            usernameController.text;
                                        String password =
                                            passwordController.text;

                                        /*if (fName.isEmpty ||
                                            lName.isEmpty ||
                                            email.isEmpty ||
                                            username.isEmpty ||
                                            password.isEmpty) {
                                          incorrectSignUp =
                                              "Some fields are empty!!!";
                                        } else {
                                          signUp();
                                        }*/

                                        signUp();

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ])),
                      Container(
                          margin: const EdgeInsets.only(top: 30.0, right: 100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "WELCOME TO",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffD9FF28),
                                  ),
                                )
                              ])),
                      Container(
                          margin: const EdgeInsets.only(right: 30, bottom: 50),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "ZIKOMMUNITY! :)",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffD9FF28),
                                  ),
                                )
                              ])),
                    ],
                  ),
                )
              ],
            )));
  }
}
