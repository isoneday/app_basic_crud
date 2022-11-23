import 'dart:convert';

import 'package:flutter_app/model/authentication_model.dart';
import 'package:http/http.dart' as http;

import '../util/constants.dart';

class KominfoNetwork {
  Future<AuthenticationModel> prosesRegister(
    String? name,
    String? email,
    String? password,
    String? phone,
  ) async {
    final response = await http.post(Uri.parse(Register));
    if (response.statusCode == 200) {
      AuthenticationModel responseModel =
          AuthenticationModel.fromJson(jsonDecode(response.body));
      return responseModel;
    } else {
      return null!;
    }
  }

  Future<AuthenticationModel> prosesLogin(
    String? email,
    String? password,
  ) async {
    final response = await http.post(Uri.parse(Login));
    if (response.statusCode == 200) {
      AuthenticationModel responseModel =
          AuthenticationModel.fromJson(jsonDecode(response.body));
      return responseModel;
    } else {
      return null!;
    }
  }
}
