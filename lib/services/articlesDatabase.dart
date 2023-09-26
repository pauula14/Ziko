import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:two_ziko/models/Article.dart';

class ArticlesDatabase {
  final String aid;
  ArticlesDatabase({this.aid});

  final CollectionReference articlesCollection =
      FirebaseFirestore.instance.collection("articles");

  Article _articlesFromSnapshot(DocumentSnapshot snapshot) {
    return Article(
        img: snapshot.get("img"),
        readedTimes: snapshot.get("readedTimes"),
        addedDate: snapshot.get("addedDate"),
        publishedDate: snapshot.get("publishedDate"),
        link: snapshot.get("link"),
        magazine: snapshot.get("magazine"),
        magazineCategory: snapshot.get("magazineCategory"),
        title: snapshot.get("title"));
  }

  Stream<Article> get articleData {
    return articlesCollection.doc(aid).snapshots().map(_articlesFromSnapshot);
  }
}
