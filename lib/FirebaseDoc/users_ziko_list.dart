import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:two_ziko/models/UserZiko.dart';

class UsersZikoList extends StatefulWidget {
  @override
  _UsersZikoListState createState() => _UsersZikoListState();
}

class _UsersZikoListState extends State<UsersZikoList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserZiko>>(context);
    /*users.forEach((user) {
      print(user.email);
      print(user.firstName);
      print(user.lastName);
      print(user.username);
    });*/

    return ListView.builder(
      itemCount: users.length,
    );
  }
}
