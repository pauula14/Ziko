import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:two_ziko/main.dart';
import 'package:two_ziko/models/Article.dart';
import 'package:two_ziko/models/UserZiko.dart';
import 'package:two_ziko/paginas/actualArticle.dart';
import 'package:two_ziko/services/articlesDatabase.dart';
//import 'package:two_ziko/FirebaseDoc/users_ziko_list.dart';
import 'package:two_ziko/services/database.dart';
import 'package:provider/provider.dart';
import 'package:two_ziko/services/myGlobals.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserPerfilPage extends StatefulWidget {
  String userID;
  UserPerfilPage(this.userID);
  @override
  State<StatefulWidget> createState() {
    return UserPerfilPageState(this.userID);
  }
}

class UserPerfilPageState extends State<UserPerfilPage> {
  String userID;
  UserPerfilPageState(this.userID);

  //final user = FirebaseAuth.instance;
  UserZiko userData;
  Article articleData;
  List<dynamic> userInterests = [];
  List<dynamic> userLikes = [];
  List<dynamic> articlesInFolder = [];
  List<dynamic> followings = [];
  List<DocumentSnapshot> allFolders = [];

  bool savedButton = true;
  bool likedButton = false;
  bool following = false;
  String followButtonContent = "FOLLOW";
  bool showModal = false;

  List<DocumentSnapshot> allArticles = [];

  Future<void> initData() async {
    //Get articles
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('articles').get();

    allArticles = result.docs;

    allArticles.forEach((data) => print(data));

    //Get interests
    final userInter = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((userInter) {
      userInterests = userInter.data()['userInterests'];
    });

    //Get folders
    final QuerySnapshot folderCollection = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('folders')
        .get();

    allFolders = folderCollection.docs;

    //Get Following
    final userFollowings = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((userFollowings) {
      followings = userFollowings.data()['followingUsers'];
    });

    //Search if is following
    if (following != null) {
      for (int i = 0; i < followings.length; i++) {
        if (followings[i] == userID) {
          print("PUTOOOO");
          following = true;
          followButtonContent = "FOLLOWING";
        }
      }
    }

    //Fill liked

    final likedArticlesUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((likedArticlesUser) {
      userLikes = likedArticlesUser.data()['liked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("AAAAAAAAAAAAAAAAAAA ${userID}");
    return StreamBuilder<UserZiko>(
        stream: DatabaseService(uid: userID).userDataProfile,
        builder: ((context, AsyncSnapshot<UserZiko> snapshot) {
          if (snapshot.hasData) {
            userData = snapshot.data;
            /*if (followings.isEmpty) {
              //following = false;
              followButtonContent = "FOLLOW";
            }*/
            return FutureBuilder(
              builder: (context, snapshot) {
                return Scaffold(
                  backgroundColor: isNightMode ? colorBlack : Colors.white,
                  body: Column(
                    children: <Widget>[
                      Expanded(flex: 1, child: this.BarraSuperior()),
                      Expanded(
                        flex: 9,
                        child: Row(children: <Widget>[
                          Expanded(flex: 1, child: this.UserName()),
                          Expanded(flex: 9, child: this.PerfilBody()),
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
          return Center(child: CircularProgressIndicator());
        }));
  }

  Widget BarraSuperior() {
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
                  navigatorKey.currentState?.pushNamed('menu');
                },
              ),
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

  Widget UserName() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: isNightMode ? colorGreen : colorBlue,
              width: 2.0,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 20),
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          userData.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        )))),
            Expanded(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "@${userData.username}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: isNightMode ? colorGreen : colorBlue,
                          ),
                        ))))
          ],
        ));
  }

  Widget PerfilBody() {
    return Column(
      children: <Widget>[
        this.PerfilInfo(),
        this.ShowingSelector(),
        savedButton ? this.FoldersSaved() : this.LikedArticles(),
      ],
    );
  }

  Widget PerfilInfo() {
    return Column(
      children: <Widget>[
        Container(
            height: 190.0,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isNightMode ? colorGreen : colorBlue,
                  width: 2.0,
                ),
              ),
            ),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    child: Image.asset(
                      'assets/img/profileImage.png',
                      height: 120.0,
                      width: 100.0,
                    )),
                SizedBox(
                    height: 140.0,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            userData.bioInterest1,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ),
                          Text(
                            userData.bioInterest2,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ),
                          Text(
                            userData.bioInterest3,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ),
                          Text(
                            userData.bioInterest4,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: isNightMode ? colorGreen : colorBlue,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15.0),
                          ),
                          SizedBox.fromSize(
                            size: Size(100, 20), // button width and height
                            child: Container(
                              decoration: BoxDecoration(
                                color: isNightMode
                                    ? (following ? colorGreen : colorBlack)
                                    : (following ? colorBlue : Colors.white),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color:
                                        isNightMode ? colorGreen : colorBlue),
                              ),
                              child: OutlinedButton(
                                child: Text(followButtonContent),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  primary: isNightMode
                                      ? (following ? colorBlack : colorGreen)
                                      : (following ? Colors.white : colorBlue),
                                  textStyle: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500
                                      //fontStyle: FontStyle.italic
                                      ),
                                ),
                                onPressed: () {
                                  following = !following;
                                  List<String> userThisID = [];
                                  userThisID.add(userID);

                                  if (following) {
                                    following = true;
                                    followButtonContent = "FOLLOWING";
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser.uid)
                                        .update({
                                      "followingUsers":
                                          FieldValue.arrayUnion(userThisID)
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser.uid)
                                        .update({
                                      "following": FieldValue.increment(1)
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userID)
                                        .update({
                                      "followers": FieldValue.increment(1)
                                    });
                                  } else {
                                    following = false;
                                    followButtonContent = "FOLLOW";
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser.uid)
                                        .update({
                                      "followingUsers":
                                          FieldValue.arrayRemove(userThisID)
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser.uid)
                                        .update({
                                      "following": FieldValue.increment(-1)
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(userID)
                                        .update({
                                      "followers": FieldValue.increment(-1)
                                    });
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ]))
              ]),
              Row(children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(children: <Widget>[
                    Text(
                      "FOLLOWERS",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                    ),
                    Text(
                      userData.followers.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 5,
                  child: Column(children: <Widget>[
                    Text(
                      "FOLLOWING",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                    ),
                    Text(
                      userData.following.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: isNightMode ? colorGreen : colorBlue,
                      ),
                    ),
                  ]),
                ),
              ])
            ])),
      ],
    );
  }

  Widget ShowingSelector() {
    return Column(children: <Widget>[
      Container(
          height: 70.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isNightMode ? colorGreen : colorBlue,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size(80, 30), // button width and height
                  child: Container(
                    decoration: BoxDecoration(
                      color: isNightMode
                          ? (savedButton ? colorGreen : colorBlack)
                          : (savedButton ? colorBlue : Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: isNightMode ? colorGreen : colorBlue),
                    ),
                    child: OutlinedButton(
                      child: Text('SAVED'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: isNightMode
                            ? (savedButton ? colorBlack : colorGreen)
                            : (savedButton ? Colors.white : colorBlue),
                        textStyle: TextStyle(
                          fontSize: 14,
                          //fontStyle: FontStyle.italic
                        ),
                      ),
                      onPressed: () {
                        if (likedButton) {
                          savedButton = true;
                          likedButton = false;
                        } else {
                          savedButton = true;
                        }

                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(80, 30), // button width and height
                  child: Container(
                    decoration: BoxDecoration(
                      color: isNightMode
                          ? (likedButton ? colorGreen : colorBlack)
                          : (likedButton ? colorBlue : Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: isNightMode ? colorGreen : colorBlue),
                    ),
                    child: OutlinedButton(
                      child: Text('LIKED'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        primary: isNightMode
                            ? (likedButton ? colorBlack : colorGreen)
                            : (likedButton ? Colors.white : colorBlue),
                        textStyle: TextStyle(
                          fontSize: 14,
                          //fontStyle: FontStyle.italic
                        ),
                      ),
                      onPressed: () {
                        if (savedButton) {
                          showModal = false;
                          savedButton = false;
                          likedButton = true;
                          setState(() {});
                        } else {
                          likedButton = true;
                        }

                        setState(() {});
                      },
                    ),
                  ),
                ),
              ]))
    ]);
  }

  Widget FoldersSaved() {
    return generateFolderButtons();
  }

  Widget generateFolderButtons() {
    List<Widget> folderButtons = [];

    if (userLikes != null) {
      for (int i = 0; i < allFolders.length; i++) {
        folderButtons.add(
            FolderButton(allFolders[i].get('folderName'), allFolders[i].id));
      }
    }

    return Expanded(
        child: ListView(padding: EdgeInsets.zero, children: folderButtons));
  }

  Widget FolderButton(String folderName, String folderId) {
    return Container(
        height: 60.0,
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
          MaterialButton(
            height: 60.0,
            onPressed: () {
              print("FOOOLDER jeje $folderId");

              final articlesIn = FirebaseFirestore.instance
                  .collection('users')
                  .doc(userID)
                  .collection('folders')
                  .doc(folderId)
                  .get()
                  .then((articlesIn) {
                articlesInFolder = articlesIn.data()['articles'];
                print(articlesIn.get('folderName'));
                print(articlesIn.data()['articles']);
              });

              showModal = true;
              print("LENNNNN ${articlesInFolder.length}");
              print("SIIII ${articlesInFolder.toString()}");
              setState(() {});
            },
            color: isNightMode ? colorBlack : Colors.white,
            child: Row(
              children: <Widget>[
                Text(
                  folderName,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: isNightMode ? colorGreen : colorBlue,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget LikedArticles() {
    return Expanded(child: generateAllArticlesLiked());
  }

  Widget generateAllArticlesLiked() {
    print("Hola");
    List<Widget> articlesLiked = [];

    for (int i = 0; i < userLikes.length; i++) {
      articlesLiked.add(LikedArticleGenerated(userLikes[i]));
    }

    return ListView(padding: EdgeInsets.zero, children: articlesLiked);
  }

  Widget LikedArticleGenerated(String idArt) {
    return StreamBuilder<Article>(
        stream: ArticlesDatabase(aid: idArt).articleData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            articleData = snapshot.data;
            print(articleData.link);
            return Container(
                alignment: Alignment.center,
                height: 80.0,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ArticlePage(idArt)));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  articleData.magazine,
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
                                  articleData.title,
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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

  Widget generateModalButtons() {
    List<Widget> modalButtons = [];

    modalButtons.add(ListTile(
        title: new Text(
          'X CLOSE',
          style: TextStyle(
            fontSize: 17,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: isNightMode ? colorGreen : colorBlue,
          ),
        ),
        onTap: () {
          print("mi cola");
          showModal = false;
          setState(() {});
        }));

    for (int i = 0; i < allArticles.length; i++) {
      for (int t = 0; t < articlesInFolder.length; t++) {
        if (allArticles[i].id == articlesInFolder[t]) {
          print("LENNN ${articlesInFolder.length}");
          print("LEN ${allArticles[i].get('magazine')}");
          modalButtons.add(modalButton(allArticles[i].get('magazine'),
              allArticles[i].get('title'), allArticles[i].id));
        }
      }
    }

    return Column(mainAxisSize: MainAxisSize.min, children: modalButtons);
  }

  Widget modalButton(String magazine, String title, String id) {
    return ListTile(
      title: Container(
          child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          color: isNightMode ? colorGreen : colorBlue,
        ),
      )),
      onTap: () {
        print("mi cola");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ArticlePage(id)));
      },
    );
  }
}
