import 'dart:convert';

import 'package:flutter_app/model/authentication_model.dart';
import 'package:flutter_app/model/model_listbarang.dart';
import 'package:http/http.dart' as http;

import '../util/constants.dart';

class KominfoNetwork {
  Future<AuthenticationModel> prosesRegister(
    String? name,
    String? email,
    String? password,
    String? phone,
  ) async {
    final response = await http.post(Uri.parse(Register), body: {
      "email": email,
      "password": password,
      "name": name,
      "hp": phone,
    });
    if (response.statusCode == 200) {
      AuthenticationModel responseModel =
          AuthenticationModel.fromJson(jsonDecode(response.body));
      return responseModel;
    } else {
      return null!;
    }
  }

//endpoint login
  Future<AuthenticationModel> prosesLogin(
    String? email,
    String? password,
  ) async {
    final response = await http.post(Uri.parse(Login), body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      AuthenticationModel responseModel =
          AuthenticationModel.fromJson(jsonDecode(response.body));
      return responseModel;
    } else {
      return null!;
    }
  }

//endpoint getlistbarang
  Future<List<Barang>?> getListBarang() async {
    final response = await http.get(Uri.parse(GetListBarang));
    List<Barang>? listBarang = [];
    if (response.statusCode == 200) {
      ModelListBarang responseModel =
          ModelListBarang.fromJson(jsonDecode(response.body));
      responseModel.barang?.forEach((element) {
        listBarang.add(element);
      });
      return listBarang;
    } else {
      return null!;
    }
  }
}
