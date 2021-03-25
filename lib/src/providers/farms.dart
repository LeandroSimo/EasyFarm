import 'dart:convert';

import 'package:easyfarm/src/models/FarmsData.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Farms with ChangeNotifier {
  FarmsData _farms;

  final String _accessToken;
  final String _uid;
  final String _client;

  Farms(
    this._accessToken,
    this._uid,
    this._client,
    this._farms,
  );

  Future<void> fetchAndSetFarms() async {
    final url = Uri.parse('https://api.easyfarm.io/v2/farms');

    try {
      final response = await http.get(url, headers: {
        'access-token': _accessToken,
        'uid': _uid,
        'client': _client
      });

      if (response.body == null) {
        return;
      }

      //final data = json.decode(response.body)['data'];

      //print(data);

      _farms = farmsDataFromJson(response.body);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  FarmsData get farms {
    return _farms;
  }
}
