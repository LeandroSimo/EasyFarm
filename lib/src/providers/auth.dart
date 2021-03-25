import 'dart:convert';

import 'package:easyfarm/src/models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:easyfarm/src/models/User.dart';

class Auth with ChangeNotifier {
  User _user;

  Future<void> signIn(String email, String password) async {
    var url = Uri.parse('https://api.easyfarm.io/v2/auth/sign_in');

    try {
      final response =
          await http.post(url, headers: {'email': email, 'password': password});
      final bodyData = json.decode(response.body) as Map<String, dynamic>;
      final headersData = response.headers;
      final data = bodyData['data'];

      if (response.statusCode == 401) {
        throw HttpException('Email ou senha incorreta!');
      }

      if (bodyData == null) {
        return;
      }
      if (headersData == null) {
        return;
      }

      _user = User(
        email: data['email'],
        name: data['name'],
        uid: headersData['uid'],
        client: headersData['client'],
        accessToken: headersData['access-token'],
      );
    } catch (error) {
      print(error);
      throw error;
    }
    notifyListeners();
  }

  bool get isAuth {
    return _user != null;
  }

  User get user {
    return _user;
  }
}
