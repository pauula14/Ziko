import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String img;
  final int readedTimes;
  final Timestamp addedDate;
  final Timestamp publishedDate;
  final String link;
  final String title;
  final String magazine;
  final String magazineCategory;
  final List<String> articleCategory;
  final List<String> atributes;

  Article(
      {this.img,
      this.readedTimes,
      this.addedDate,
      this.publishedDate,
      this.link,
      this.title,
      this.magazine,
      this.magazineCategory,
      this.articleCategory,
      this.atributes});
}
