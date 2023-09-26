import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/models/Article.dart';
import 'package:two_ziko/paginas/actualArticle.dart';
import 'package:two_ziko/paginas/user_profile.dart';
import 'package:two_ziko/services/myGlobals.dart';

class ExploraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExploraPageState();
  }
}

class ExploraPageState extends State<ExploraPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getArticles());
  }

  final userSearch = TextEditingController();
  String usernameSearched;
  String idUsernameSearched;
  String nameSearched;
  bool usernameFounded = false;

  //Article article;
  List<DocumentSnapshot> allArticles = [];

  Future<void> getArticles() async {
    print("chichito");

    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('articles').get();

    allArticles = result.docs;

    allArticles.forEach((data) => print(data));

    //print("length 2 ${allArticles.length}");
  }

  List<DocumentSnapshot> allUsers = [];

  Future<void> getUsers() async {
    print("chichon");

    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('users').get();

    allUsers = result.docs;

    allUsers.forEach((data) => print(data));

    //print("length 2 ${allArticles.length}");
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
      future: getArticles(),
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
          Container(
            width: 180,
            height: 27,
            child: TextField(
              style: TextStyle(
                  //fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: isNightMode ? colorGreen : colorBlue),
              onChanged: (value) {
                getUsers();
                int number;

                for (int i = 0; i < allUsers.length; i++) {
                  if (userSearch.text.toLowerCase() ==
                      allUsers[i].get("username").toLowerCase()) {
                    usernameFounded = true;
                    idUsernameSearched = allUsers[i].id;
                    nameSearched = allUsers[i].get("name");
                    usernameSearched = userSearch.text;

                    setState(() {});
                  } else {}
                }

                if (userSearch.text == '') {
                  usernameFounded = false;
                  setState(() {});
                }
              },
              controller: userSearch,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Buscar...',
                  isDense: true, // Added this
                  contentPadding: EdgeInsets.all(8),
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: isNightMode ? colorGreen : colorBlue)),
            ),
          ),
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
    if (usernameFounded) {
      return Container(
          margin: EdgeInsets.only(bottom: 250),
          alignment: Alignment.center,
          height: 100.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isNightMode ? colorGreen : colorBlue,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    print("hola");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            UserPerfilPage(idUsernameSearched)));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 170,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            usernameSearched,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          )),
                      Container(
                          width: 150,
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            nameSearched,
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          )),
                    ],
                  ),
                ),
              ]));
    } else {
      return generateAllArticles();
    }
  }

  Widget generateAllArticles() {
    print("Hola");
    List<Widget> articles = [];

    for (int i = 0; i < allArticles.length; i++) {
      articles.add(generateArticleButton(allArticles[i].get("magazine"),
          allArticles[i].get("title"), allArticles[i].id));
    }

    return ListView(padding: EdgeInsets.zero, children: articles);
  }

  Widget generateArticleButton(String magazine, String title, String id) {
    return Container(
        alignment: Alignment.center,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isNightMode ? colorGreen : colorBlue,
              width: 2.0,
            ),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          TextButton(
            onPressed: () {
              print("hola");
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ArticlePage(id)));
            },
            child: Row(
              children: <Widget>[
                Container(
                    width: 100,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      magazine,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    )),
                Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      title,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    )),
              ],
            ),
          ),
        ]));
  }
}
