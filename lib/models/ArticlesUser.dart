import 'package:sembast/timestamp.dart';

class ArticlesUser {
  final int id;
  final String name;
  final String author;
  final DateTime date;

  ArticlesUser({this.id, this.name, this.author, this.date});

  factory ArticlesUser.fromJson(Map<String, dynamic> json) =>
      _articlesUserFromJson(json);

  Map<String, dynamic> toJson() => _articlesUserToJson(this);

  @override
  String toString() => 'ArticlesUser<$id>';
}

ArticlesUser _articlesUserFromJson(Map<String, dynamic> json) {
  return ArticlesUser(
      id: json['id'] as int,
      name: json['name'] as String,
      author: json['author'] as String,
      date: (json['date'] as Timestamp).toDateTime());
}

Map<String, dynamic> _articlesUserToJson(ArticlesUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'date': instance.date
    };
