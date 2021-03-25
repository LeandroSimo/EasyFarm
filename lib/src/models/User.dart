import 'package:flutter/foundation.dart';

class User {
  String uid;
  String name;
  String email;
  String client;
  String accessToken;

  User({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.client,
    @required this.accessToken,
  });
}
