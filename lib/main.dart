import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:two_ziko/paginas/curatedBy.dart';
import 'package:two_ziko/paginas/explora.dart';
import 'package:two_ziko/paginas/actualArticle.dart';
import 'package:two_ziko/paginas/notificaciones.dart';
import 'package:two_ziko/paginas/registro.dart';
import 'package:two_ziko/paginas/profileSelector.dart';
import 'package:two_ziko/paginas/interestsSelector.dart';
import 'package:two_ziko/paginas/login.dart';
import 'package:two_ziko/paginas/mi_perfil.dart';
import 'package:two_ziko/paginas/inicio.dart';
import 'package:two_ziko/paginas/menu.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:two_ziko/services/myGlobals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  //const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "register": (BuildContext context) => CreateAccountPage(),
        "step1_register": (BuildContext context) => InterestsPage(),
        "step2_register": (BuildContext context) => ProfileSelectorPage(),
        "mainPage": (BuildContext context) => InicioPage(),
        "profile": (BuildContext context) => MiPerfilPage(),
        "menu": (BuildContext context) => MenuPage(),
        "explore": (BuildContext context) => ExploraPage(),
        "notifications": (BuildContext context) => NotificationsPage(),
        "curatedBy": (BuildContext context) => CuratedBy(),
        "article": (BuildContext context) => ArticlePage(null),
      },
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //isNightMode = false;
            return InicioPage();

            //print("hola");
          } else {
            return LoginPage();
            //print("no");
          }
        },
      ),

      /*FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('You have an error ${snapshot.error.toString()}');
          } else if (snapshot.hasData) {
            //return LoginPage();
            return StreamBuilder<User>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return MiPerfilPage();
              },
            );
          } else {
            return MiPerfilPage();
          }
        },
      ),*/
    );
    throw UnimplementedError();
  }
}
