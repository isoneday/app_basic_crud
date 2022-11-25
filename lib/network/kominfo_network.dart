import 'dart:convert';

import 'package:flutter_app/model/authentication_model.dart';
import 'package:http/http.dart' as http;

import '../providers/barang.dart';
import '../providers/model_listbarang.dart';
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

  Future insertBarang(nama, harga, url, detail) async {
    // var stream = new http.ByteStream(DelegatingStream.typed(url.openRead()));
    // var length = await url.length();
    // final uri =
    //     Uri.http(_host, "server_inventory-master/index.php/api/insertBarang");
    Uri uri = Uri.parse(InsertBarang);
    // var fileStream = http.ByteStream(uri);
    // fileStream.cast();
    // var length = await url.length();

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = await http.MultipartFile.fromPath("gambar", url);
    //  var multipartFile = http.MultipartFile("gambar", fileStream, length,
    // filename: url);
    request.fields["nama"] = nama;
    request.fields["harga"] = harga;
    request.fields["detail"] = detail;

    request.files.add(multipartFile);
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
    return response.reasonPhrase;
  }

  Future<List<Barang>> getListBarang() async {
    final uri =
        Uri.parse("${BaseURL}server_inventory-master/index.php/api/getBarang");
    List<Barang> listProduct = [];
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ModelListBarang dataProduct = ModelListBarang.fromJson(json);
      dataProduct.barang?.forEach((element) {
        listProduct.add(element);
      });
      return listProduct;
    } else {
      return null!;
    }
  }

  // Future<ModelListBarang> deleteBarang(id) async {
  //   final uri = Uri.parse(DeleteBarang);
  //   final response = await http.post(uri, body: {'id': id});
  //   if (response.statusCode == 200) {
  //     ModelListBarang responseRequest =
  //         ModelListBarang.fromJson(jsonDecode(response.body));
  //     return responseRequest;
  //   } else {
  //     return null!;
  //   }
  // }

  Future updateProduct(id, nama, harga, url, detail) async {
    // var stream = new http.ByteStream(DelegatingStream.typed(url.openRead()));
    // var length = await url.length();
    Uri uri = Uri.parse(UpdateBarang);

    // final uri =
    //     Uri.http(_host, "server_inventory-master/index.php/api/updateBarang");
    final request = new http.MultipartRequest("POST", uri);

    request.fields['id'] = id;
    request.fields['nama'] = nama;
    request.fields['harga'] = harga;
    request.fields['detail'] = detail;

    var multipartFile = await http.MultipartFile.fromPath("gambar", url);
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("berhasil upload");
    }
    return response.reasonPhrase;
  }

  // Future<ModelListBarang> updateBarangTanpaGambar(
  //     id, nama, harga, gambar, detail) async {
  //   final uri = Uri.parse(UpdateTanpaBarang);
  //   final response = await http.post(uri, body: {
  //     "id": id,
  //     "nama": nama,
  //     "harga": harga,
  //     "gambar": gambar,
  //     "detail": detail
  //   });
  //   if (response.statusCode == 200) {
  //     ModelListBarang responseProduct =
  //         ModelListBarang.fromJson(jsonDecode(response.body));
  //     return responseProduct;
  //   } else {
  //     return null!;
  //   }
  // }
}
