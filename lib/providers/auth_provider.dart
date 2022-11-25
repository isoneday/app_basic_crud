import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../util/constants.dart'; 

class AuthProvider with ChangeNotifier {
  Future<bool> login(String email, String passowrd) async {
    final url =
        "http://udakita.com/server_inventory-master/index.php/api/login";
    var uri = Uri.parse(url);
    final response = await http.post(uri, body: {
      'email': email,
      'password': passowrd,
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['sukses'] == true) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(
      String email, String passowrd, String name, String nohp) async {
    final url =
        "http://${BaseURL}/server_inventory-master/index.php/api/register";
    var uri = Uri.parse(url);
    final response = await http.post(uri, body: {
      'email': email,
      'password': passowrd,
      'name': name,
      'hp': nohp,
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['sukses'] == true) {
      // notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
