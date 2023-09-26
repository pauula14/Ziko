import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:two_ziko/models/UserZiko.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String email, String firstName, String lastName, String username) async {
    return await usersCollection.doc(uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      /*'bio_interst1': '',
      'bio_interst2': '',
      'bio_interst3': '',
      'bio_interst4': '',
      'userInterests': '',
      'following': '',
      'followers': '',
      'liked': '',
      'readed': '',
      'folders': '',*/
    });
  }

  Future updateUserInterests(List<String> userSelInterests) async {
    return await usersCollection
        .doc(uid)
        .set({'userInterests': userSelInterests}, SetOptions(merge: true));
  }

  Future updateReadedArticles(List<String> newArticleID) async {
    return await usersCollection
        .doc(uid)
        .update({"readed": FieldValue.arrayUnion(newArticleID)});
  }

  Future updateLikedArticles(List<String> newArticleID) async {
    return await usersCollection
        .doc(uid)
        .update({"liked": FieldValue.arrayUnion(newArticleID)});
  }

  Future deleteLikedArticles(List<String> newArticleID) async {
    return await usersCollection
        .doc(uid)
        .update({"liked": FieldValue.arrayRemove(newArticleID)});
  }

  Future updateStep2(
      String one, String two, String three, String four, String name) async {
    return await usersCollection.doc(uid).set({
      'bioInterest1': one,
      'bioInterest2': two,
      'bioInterest3': three,
      'bioInterest4': four,
      'name': name,
      'followers': 0,
      'following': 0
    }, SetOptions(merge: true));
  }

  //Users list from snapshoot
  List<UserZiko> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((userConcrete) {
      return UserZiko(
        name: userConcrete.get('name') ?? '',
        email: userConcrete.get('email') ?? '',
        firstName: userConcrete.get('firstName') ?? '',
        lastName: userConcrete.get('lastName') ?? '',
        username: userConcrete.get('username') ?? '',
        bioInterest1: userConcrete.get('bioInterest1') ?? '',
        bioInterest2: userConcrete.get('bioInterest2') ?? '',
        bioInterest3: userConcrete.get('bioInterest3') ?? '',
        bioInterest4: userConcrete.get('bioInterest4') ?? '',
        userInterests: userConcrete.get('userInterests') ?? '',
        following: userConcrete.get('following') ?? '',
        followers: userConcrete.get('followers') ?? '',
        /*liked: _convertArticles(userConcrete.get('liked') as List<dynamic>),
          readed: _convertArticles(userConcrete.get('readed') as List<dynamic>),
          folders:
              _convertFolders(userConcrete.get('folders') as List<dynamic>)*/
      );
    }).toList();
  }

  //User data from snapchot
  UserZiko _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserZiko(
      name: snapshot.get('name') ?? '',
      email: snapshot.get('email') ?? '',
      firstName: snapshot.get('firstName') ?? '',
      lastName: snapshot.get('lastName') ?? '',
      username: snapshot.get('username') ?? '',
      bioInterest1: snapshot.get('bioInterest1') ?? '',
      bioInterest2: snapshot.get('bioInterest2') ?? '',
      bioInterest3: snapshot.get('bioInterest3') ?? '',
      bioInterest4: snapshot.get('bioInterest4') ?? '',
      userInterests: snapshot.get('userInterests') ?? '',
      following: snapshot.get('following') ?? '',
      followers: snapshot.get('followers') ?? '',
    );
  }

  //Map<String, dynamic> () => {'interest': insterest}

  UserZiko _userDataFromSnapshotProfile(DocumentSnapshot snapshot) {
    return UserZiko(
      name: snapshot.get('name') ?? '',
      email: snapshot.get('email') ?? '',
      firstName: snapshot.get('firstName') ?? '',
      lastName: snapshot.get('lastName') ?? '',
      username: snapshot.get('username') ?? '',
      bioInterest1: snapshot.get('bioInterest1') ?? '',
      bioInterest2: snapshot.get('bioInterest2') ?? '',
      bioInterest3: snapshot.get('bioInterest3') ?? '',
      bioInterest4: snapshot.get('bioInterest4') ?? '',
      //userInterests: snapshot.get('userInterests'),
      following: snapshot.get('following') ?? '',
      followers: snapshot.get('followers') ?? '',
    );
  }

  //User data from snapchot
  UserZiko _userDataFromSnapshotStep2(DocumentSnapshot snapshot) {
    return UserZiko(
      email: snapshot.get('email') ?? '',
      firstName: snapshot.get('firstName') ?? '',
      lastName: snapshot.get('lastName') ?? '',
      username: snapshot.get('username') ?? '',
    );
  }

  //Get the collection stream
  Stream<List<UserZiko>> get users {
    return usersCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<UserZiko> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<UserZiko> get userDataStep2 {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshotStep2);
  }

  Stream<UserZiko> get userDataProfile {
    return usersCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshotProfile);
  }
}
