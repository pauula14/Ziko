import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:two_ziko/models/ArticlesUser.dart';
import 'package:two_ziko/models/Folder.dart';

class UserZiko {
  final String name;
  final String email;
  final String firstName;
  final String lastName;
  final String username;

  final String bioInterest1;
  final String bioInterest2;
  final String bioInterest3;
  final String bioInterest4;

  final List<String> userInterests;
  final int followers;
  final int following;

  final List<ArticlesUser> liked;
  final List<ArticlesUser> readed;
  final List<Folder> folders;

  DocumentReference reference;

  UserZiko(
      {this.name,
      this.email,
      this.firstName,
      this.lastName,
      this.username,
      this.bioInterest1,
      this.bioInterest2,
      this.bioInterest3,
      this.bioInterest4,
      this.userInterests,
      this.followers,
      this.following,
      this.liked,
      this.readed,
      this.folders});
/*
  factory UserZiko.fromSnapshot(DocumentSnapshot snapshot) {
    final newUser = UserZiko.fromJson(snapshot.data() as Map<String, dynamic>);
    return newUser;
  }

  factory UserZiko.fromJson(Map<String, dynamic> json) => _userFromJson(json);

  Map<String, dynamic> toJson() => _userToJson(this);

  String toString() => 'UserZiko<$name>';*/
}

/*
UserZiko _userFromJson(Map<String, dynamic> json) {
  return UserZiko(
    name: json['name'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    username: json['username'] as String,
    bioInterest1: json['bioInterest1'] as String,
    bioInterest2: json['bioInterest2'] as String,
    bioInterest3: json['bioInterest3'] as String,
    bioInterest4: json['bioInterest4'] as String,
    userInterests: json['userInterests'] as List<String>,
    following: json['following'] as int,
    followers: json['followers'] as int,
    liked: _convertArticles(json['liked'] as List<dynamic>),
    readed: _convertArticles(json['readed'] as List<dynamic>),
    folders: _convertFolders(json['folders'] as List<dynamic>),
  );
}

List<ArticlesUser> _convertArticles(List<dynamic> articlesMap) {
  final articles = <ArticlesUser>[];

  for (final article in articles) {
    articles.add(ArticlesUser.fromJson(article as Map<String, dynamic>));
  }

  return articles;
}

List<Folder> _convertFolders(List<dynamic> foldersMap) {
  final folders = <Folder>[];

  for (final folder in folders) {
    folders.add(Folder.fromJson(folder as Map<String, dynamic>));
  }

  return folders;
}

Map<String, dynamic> _userToJson(UserZiko instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'bioInterest1': instance.bioInterest1,
      'bioInterest2': instance.bioInterest2,
      'bioInterest3': instance.bioInterest3,
      'bioInterest4': instance.bioInterest4,
      'userInterests': instance.userInterests,
      'following': instance.following,
      'followers': instance.followers,
      'liked': _articlesList(instance.liked),
      'readed': _articlesList(instance.readed),
      'folders': _foldersList(instance.folders),
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

List<Map<String, dynamic>> _foldersList(List<Folder> folders) {
  if (folders == null) {
    return null;
  }

  final foldersMap = <Map<String, dynamic>>[];
  folders.forEach((folder) {
    foldersMap.add(folder.toJson());
  });
  return foldersMap;
}*/
