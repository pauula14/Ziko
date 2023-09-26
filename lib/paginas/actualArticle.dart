import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:two_ziko/main.dart';
import 'package:two_ziko/models/Article.dart';

import 'package:two_ziko/services/articlesDatabase.dart';
import 'package:two_ziko/services/database.dart';
import 'package:two_ziko/services/myGlobals.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticlePage extends StatefulWidget {
  String articleID;
  ArticlePage(this.articleID);

  @override
  State<StatefulWidget> createState() {
    return ArticlePageState(this.articleID);
  }
}

class ArticlePageState extends State<ArticlePage> {
  final user = FirebaseAuth.instance.currentUser;
  String articleID;
  Article actualArticle;
  ArticlePageState(this.articleID);
  List<String> articlesReaded;
  bool articleLiked = false;
  List<dynamic> userLikes = [];
  List<String> folderNames = [];
  bool showModal = false;
  bool showNewFolder = false;
  final folderNameController = new TextEditingController();

  _launchLink(String link) async {
    await launchUrlString(link);
  }

  void addArticleReaded(idArticle) async {
    List<String> ids = [idArticle];
    await DatabaseService(uid: user.uid).updateReadedArticles(ids);
  }

  void addArticleLiked(idArticle) async {
    List<String> ids = [idArticle];
    await DatabaseService(uid: user.uid).updateLikedArticles(ids);
  }

  void deleteArticleLiked(idArticle) async {
    List<String> ids = [idArticle];
    await DatabaseService(uid: user.uid).deleteLikedArticles(ids);
  }

  //Return articles liked to know if teh article is liked

  List<DocumentSnapshot> allFolders = [];

  Future<void> initData() async {
    //Get folders
    final QuerySnapshot folderCollection = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('folders')
        .get();

    allFolders = folderCollection.docs;

    print("ñeeeee ${folderCollection.docs}");

    allFolders.forEach((element) {
      print("AAAAAAAAA $element");
    });

    //Fill liked
    final likedArticlesUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((likedArticlesUser) {
      userLikes = likedArticlesUser.data()['liked'];
      articleLiked = false;
      if (userLikes != null) {
        for (int i = 0; i < userLikes.length; i++) {
          if (userLikes[i] == articleID) {
            articleLiked = true;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Article>(
      stream: ArticlesDatabase(aid: articleID).articleData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          actualArticle = snapshot.data;
          return FutureBuilder(
            builder: (context, snapshot) {
              return Scaffold(
                backgroundColor: isNightMode ? colorBlack : Colors.white,
                body: Column(
                  children: <Widget>[
                    Expanded(flex: 1, child: this.BarraSuperior()),
                    Expanded(
                      flex: 9,
                      child: ListView(children: [
                        Stack(children: <Widget>[
                          this.ArticleContent(),
                          this.ArticleData(),
                        ])
                      ]),
                    ),
                  ],
                ),
                bottomSheet: _showModalBottomSheet(),
              );
            },
            future: initData(),
          );
        }
      },
    );
  }

  Widget BarraSuperior() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
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
                      backgroundColor:
                          isNightMode ? colorGreen : Color(0xff6671D2),
                      textStyle: TextStyle(
                        fontSize: 14,
                        //fontStyle: FontStyle.italic
                      ),
                    ),
                    onPressed: () {
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
              ),
            ],
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

  Widget ArticleData() {
    return Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(left: 30, top: 60),
            alignment: Alignment.topLeft,
            child: Text(
              actualArticle.title,
              style: TextStyle(
                fontSize: 50,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: isNightMode ? colorGreen : colorBlue,
              ),
            )),
        Container(
            margin: const EdgeInsets.only(left: 30),
            alignment: Alignment.topLeft,
            child: Text(
              actualArticle.magazine,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w400,
                color: isNightMode ? colorGreen : colorBlue,
              ),
            ))
      ],
    );
  }

  Widget ArticleContent() {
    return Column(
      children: [
        this.ArticleContainer(),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20),
            child: SizedBox.fromSize(
              size: Size(150, 40), // button width and height
              child: Container(
                child: OutlinedButton(
                  child: Text('comments'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorGreen : colorBlue,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              ),
            )),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20, top: 40, bottom: 40),
            child: SizedBox.fromSize(
              size: Size(150, 40), // button width and height
              child: Container(
                child: OutlinedButton(
                  child: Text('<-------'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    primary: isNightMode ? colorGreen : colorBlue,
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    print('Pressed');
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )),
      ],
    );
  }

  Widget ArticleContainer() {
    return FutureBuilder(
      builder: (context, snapshot) {
        return Container(
            margin: const EdgeInsets.only(left: 70, top: 180),
            child: Row(
              children: <Widget>[
                RotatedBox(
                  quarterTurns: 3,
                  child: SizedBox.fromSize(
                    size: Size(500, 45), // button width and height
                    child: Container(
                      margin: const EdgeInsets.only(right: 320),
                      decoration: BoxDecoration(
                        color: isNightMode ? colorGreen : colorBlue,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('Read more'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorBlack : Colors.white,
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          print('Pressed');
                          addArticleReaded(articleID);
                          _launchLink(actualArticle.link);
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 40),
                  width: 540,
                  height: 700,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: isNightMode ? colorGreen : colorBlue,
                          width: 2.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            actualArticle.img,
                            height: 550.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox.fromSize(
                              size: Size(150, 60), // button width and height
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: isNightMode ? colorGreen : colorBlue,
                                  ),
                                ),
                                child: OutlinedButton(
                                  child: Text('+++'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    primary:
                                        isNightMode ? colorGreen : colorBlue,
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: () {
                                    print('Pressed');
                                    //getFolders();
                                    showModal = true;
                                    setState(() {});
                                    //return _showModalBottomSheet();
                                  },
                                ),
                              ),
                            ),
                            SizedBox.fromSize(
                              size: Size(150, 60), // button width and height
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color:
                                          isNightMode ? colorGreen : colorBlue,
                                    ),
                                    color: isNightMode
                                        ? (articleLiked
                                            ? colorGreen
                                            : colorBlack)
                                        : (articleLiked
                                            ? colorBlue
                                            : Colors.white)),
                                child: OutlinedButton(
                                  child: Text('LIKE <3'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    primary: isNightMode
                                        ? (articleLiked
                                            ? colorBlack
                                            : colorGreen)
                                        : (articleLiked
                                            ? Colors.white
                                            : colorBlue),
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: () {
                                    print('Pressed');
                                    articleLiked = !articleLiked;
                                    setState(() {});
                                    if (articleLiked) {
                                      addArticleLiked(articleID);
                                    } else {
                                      deleteArticleLiked(articleID);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                )
              ],
            ));
      },
      //future: getFolders(),
    );
  }

  Widget generateModalButtons() {
    List<Widget> modalButtons = [];

    modalButtons.add(ListTile(
        title: new Text(
          'X CLOSE',
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: isNightMode ? colorGreen : colorBlue,
          ),
        ),
        onTap: () {
          print("mi cola");
          showModal = false;
          setState(() {});
        }));

    for (int i = 0; i < allFolders.length; i++) {
      modalButtons
          .add(modalButton(allFolders[i].get('folderName'), allFolders[i].id));
    }

    modalButtons.add(ListTile(
        title: new Text(
          'ADD FOLDER +',
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: isNightMode ? colorGreen : colorBlue,
          ),
        ),
        onTap: () {
          print("mi cola");
          showModal = false;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: isNightMode ? colorBlack : Colors.white,
                title: Text("ADD new folder +",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: isNightMode ? colorGreen : colorBlue,
                    )),
                content: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: 160,
                  height: 30,
                  child: TextField(
                    controller: folderNameController,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: isNightMode ? colorGreen : colorBlue),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isNightMode ? colorGreen : colorBlue,
                              width: 1.5),
                        ),
                        hintText: 'Folder name',
                        contentPadding: EdgeInsets.all(8),
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: isNightMode ? colorGreen : colorBlue)),
                  ),
                ),
                actions: [
                  SizedBox.fromSize(
                    size: Size(80, 45), // button width and height
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('cancel'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorGreen : colorBlue,
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          print('Pressed');
                          folderNameController.text = '';
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(80, 40), // button width and height
                    child: Container(
                      //margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                        color: isNightMode ? colorGreen : colorBlue,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: isNightMode ? colorGreen : colorBlue),
                      ),
                      child: OutlinedButton(
                        child: Text('add'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          primary: isNightMode ? colorBlack : Colors.white,
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          print('Pressed');
                          //String newId = FirebaseFirestore.

                          if (folderNameController.text != '') {
                            print(folderNameController.text);
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('folders')
                                .doc()
                                .set({'folderName': folderNameController.text});
                          }
                          folderNameController.text = '';
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          setState(() {});
        }));

    return Column(mainAxisSize: MainAxisSize.min, children: modalButtons);
  }

  Widget modalButton(String folderName, String folderID) {
    return ListTile(
      title: new Text(
        folderName,
        style: TextStyle(
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
          color: isNightMode ? colorGreen : colorBlue,
        ),
      ),
      onTap: () {
        print("mi cola");
        List<dynamic> articleToAdd = [];
        articleToAdd.add(articleID);

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('folders')
            .doc(folderID)
            .update({"articles": FieldValue.arrayUnion(articleToAdd)});
        //allFolders[1].data()

        showModal = false;
        setState(() {});
      },
    );
  }

  Widget _showModalBottomSheet() {
    if (showModal) {
      return BottomSheet(
          backgroundColor: isNightMode ? colorBlack : Colors.white,
          onClosing: () {},
          builder: (context) {
            return generateModalButtons();
          });
    } else {
      return null;
    }
  }
}
