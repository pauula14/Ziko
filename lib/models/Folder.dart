import 'package:two_ziko/models/ArticlesUser.dart';

class Folder {
  final String name;
  final List<ArticlesUser> folderArticles;

  Folder({this.name, this.folderArticles});

  /*factory Folder.fromJson(Map<String, dynamic> json) => _folderFromJson(json);

  Map<String, dynamic> toJson() => _folderToJson(this);

  @override
  String toString() => 'Folder<$id>';*/
}

/*Folder _folderFromJson(Map<String, dynamic> json) {
  return Folder(
      id: json['id'] as int,
      name: json['name'] as String,
      folderArticles:
          _convertArticles(json['folderArticles'] as List<dynamic>));
}

List<ArticlesUser> _convertArticles(List<dynamic> articlesMap) {
  final articles = <ArticlesUser>[];

  for (final article in articlesMap) {
    articles.add(ArticlesUser.fromJson(article as Map<String, dynamic>));
  }

  return articles;
}

Map<String, dynamic> _folderToJson(Folder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': _articlesList(instance.folderArticles)
    };

List<Map<String, dynamic>> _articlesList(List<ArticlesUser> articles) {
  if (articles == null) {
    return null;
  }

  final articlesMap = <Map<String, dynamic>>[];
  articles.forEach((article) {
    articlesMap.add(article.toJson());
  });
  return articlesMap;
}
*/