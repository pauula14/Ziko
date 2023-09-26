import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/FirebaseDoc/users_ziko_list.dart';
import 'package:two_ziko/models/Article.dart';
import 'package:two_ziko/paginas/actualArticle.dart';
import 'package:two_ziko/services/database.dart';
import 'package:two_ziko/models/UserZiko.dart';
import 'package:two_ziko/services/myGlobals.dart';

class InicioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InicioPageState();
  }
}

class InicioPageState extends State<InicioPage> {
  final user = FirebaseAuth.instance.currentUser;
  List<dynamic> userReads = [];
  List<dynamic> userInterests = [];
  List<DocumentSnapshot> allArticles = [];

  String randomReadedRecommend = '';

  Future<void> initData() async {
    print("chichitoweno");

    //Gets all th articles
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('articles').get();

    allArticles = result.docs;
    allArticles.forEach((data) => print(data));

    //Fills the reades articles
    final readedArticlesUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((readedArticlesUser) {
      userReads = readedArticlesUser.data()['readed'];
    });

    //Fills the user interests
    final userInter = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((userInter) {
      userInterests = userInter.data()['userInterests'];
    });

    int readedLength = userReads.length;
    Random random = new Random();
    int randomNum = random.nextInt(readedLength);
    String idReaded = userReads[randomNum];

    for (int i = 0; i < allArticles.length; i++) {
      if (allArticles[i].id == idReaded) {
        randomReadedRecommend = allArticles[i].get("magazine");
      }
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
                child: Row(children: <Widget>[
                  Expanded(flex: 9, child: this.InicioBody()),
                  Expanded(flex: 1, child: this.BarraLat()),
                ]),
              ),
            ],
          ),
        );
      },
      future: initData(),
    );
  }

  Widget InicioBody() {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          child: this.MenuButton(),
        ),
        Container(
          height: 80,
          child: Image.asset(
            isNightMode
                ? 'assets/img/logo_verde.png'
                : 'assets/img/logo_azul.png',
            height: 50.0,
          ),
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 2.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "${DateTime.now().day.toString()} - 0${DateTime.now().month.toString()}",
                  style: TextStyle(
                    fontSize: 60,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = isNightMode ? colorGreen : colorBlue,
                  ),
                ),
                Text(
                  "news",
                  style: TextStyle(
                    fontSize: 60,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: isNightMode ? colorGreen : colorBlue,
                  ),
                )
              ]),
        ),
        Expanded(
            child: ListView(
          children: [
            Container(
              height: 320,
              child: this.RecomendadosParaTi(),
            ),
            if (userReads != null)
              (Container(
                height: 320,
                child: this.PorqueLeiste(),
              )),
            if (userReads != null)
              (Container(
                height: 320,
                child: this.LeidoRecientemente(),
              )),
            Container(
              height: 320,
              child: this.TendenciasActuales(),
            ),
            Container(
              height: 320,
              child: this.Novedades(),
            ),
          ],
        )),
      ],
    );
  }

  Widget GenerateRecommended() {
    List<Widget> recommendedArticles = [];
    List<DocumentSnapshot> interestsFromMagazines = [];

    for (int i = 0; i < userInterests.length; i++) {
      for (int t = 0; t < allArticles.length; t++) {
        if (userInterests[i] == allArticles[t].get("magazineCategory")) {
          interestsFromMagazines.add(allArticles[t]);
        }
      }

      for (int i = 0; i < interestsFromMagazines.length; i++) {
        print("interest ${interestsFromMagazines[i].get("title")}");
        recommendedArticles.add(createArticle(
            interestsFromMagazines[i].get("title"),
            interestsFromMagazines[i].get("magazine"),
            interestsFromMagazines[i].id,
            interestsFromMagazines[i].get("img")));
      }

      return ListView(
          scrollDirection: Axis.horizontal, children: recommendedArticles);
    }

    print("longitud ${interestsFromMagazines.length}");
  }

  Widget GenerateReaded() {
    List<Widget> readingArticles = [];
    List<DocumentSnapshot> readed = [];

    for (int i = 0; i < allArticles.length; i++) {
      if (userReads != null) {
        for (int t = 0; t < userReads.length; t++) {
          if (userReads[t] == allArticles[i].id) {
            readed.add(allArticles[i]);
          }
        }
      }
    }

    for (int i = 0; i < readed.length; i++) {
      readingArticles.add(createArticle(readed[i].get("title"),
          readed[i].get("magazine"), readed[i].id, readed[i].get("img")));
    }

    return ListView(
        scrollDirection: Axis.horizontal, children: readingArticles);
  }

  Widget GenerateBecause() {
    List<Widget> becauseArticles = [];

    for (int i = 0; i < allArticles.length; i++) {
      if (randomReadedRecommend == allArticles[i].get("magazine")) {
        becauseArticles.add(createArticle(
            allArticles[i].get("title"),
            allArticles[i].get("magazine"),
            allArticles[i].id,
            allArticles[i].get("img")));
      }
    }

    return ListView(
        scrollDirection: Axis.horizontal, children: becauseArticles);
  }

  Widget GenerateTrendies() {
    List<Widget> trendyArticles = [];

    for (int i = 0; i < allArticles.length; i++) {
      if (allArticles[i].get("readedTimes") > 2) {
        trendyArticles.add(createArticle(
            allArticles[i].get("title"),
            allArticles[i].get("magazine"),
            allArticles[i].id,
            allArticles[i].get("img")));
      }
    }
    return ListView(scrollDirection: Axis.horizontal, children: trendyArticles);
  }

  Widget GenerateNewest() {
    List<Widget> newestArticles = [];
    DateTime today = new DateTime.now();

    for (int i = 0; i < allArticles.length; i++) {
      Timestamp articleData = allArticles[i].get("publishedDate");
      DateTime articleDay = articleData.toDate();
      var differenceBetween = today.difference(articleDay);
      if (differenceBetween.inDays < 7) {
        print("hola");
        newestArticles.add(createArticle(
            allArticles[i].get("title"),
            allArticles[i].get("magazine"),
            allArticles[i].id,
            allArticles[i].get("img")));
      }
    }

    return ListView(scrollDirection: Axis.horizontal, children: newestArticles);
  }

  Widget MenuButton() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                //FirebaseAuth.instance.signOut();
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
        ),
      ],
    );
  }

  Widget RecomendadosParaTi() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "recomendados",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: isNightMode ? colorGreen : colorBlue,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "para ti",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: isNightMode ? colorGreen : colorBlue,
                  ),
                )),
          ),
          Expanded(
            child: Container(
              height: 320.0,
              child: GenerateRecommended(),
            ),
          )
        ]);
  }

  Widget PorqueLeiste() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Porque",
                        style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w300,
                          color: isNightMode ? colorGreen : colorBlue,
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "leíste",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          color: isNightMode ? colorGreen : colorBlue,
                        ),
                      )),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox.fromSize(
                size: Size(215, 70), // button width and height
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border:
                        Border.all(color: isNightMode ? colorGreen : colorBlue),
                  ),
                  child: OutlinedButton(
                    child: Text(randomReadedRecommend),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.only(left: 20),
                      primary: isNightMode ? colorGreen : colorBlue,
                      textStyle: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                    ),
                    onPressed: () {
                      print('Pressed');
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(child: Container(height: 320.0, child: GenerateBecause()))
      ],
    );
  }

  Widget LeidoRecientemente() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Leído",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: isNightMode ? colorGreen : colorBlue,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "recientemente",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w300,
                      color: isNightMode ? colorGreen : colorBlue,
                    ),
                  )),
            ),
          ],
        ),
        Expanded(child: Container(height: 180.0, child: GenerateReaded()))
      ],
    );
  }

  Widget TendenciasActuales() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "Tendencias",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: isNightMode ? colorGreen : colorBlue,
                ),
              )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "Actuales",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  color: isNightMode ? colorGreen : colorBlue,
                ),
              )),
        ),
        Expanded(child: Container(height: 180.0, child: GenerateTrendies()))
      ],
    );
  }

  Widget Novedades() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "Novedades",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: isNightMode ? colorGreen : colorBlue,
                ),
              )),
        ),
        Expanded(child: Container(height: 180.0, child: GenerateNewest()))
      ],
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

  Widget createArticle(String title, String magazine, String id, String img) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0, left: 15.0),
      width: 120.0,
      child: TextButton(
          onPressed: () {
            print("helooooo");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ArticlePage(id)));
          },
          child: Column(children: <Widget>[
            Image.asset(
              img,
              height: 90.0,
              width: 70.0,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  magazine,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isNightMode ? colorGreen : colorBlue,
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: isNightMode ? colorGreen : colorBlue,
                  ),
                )),
          ])),
    );
  }
}
