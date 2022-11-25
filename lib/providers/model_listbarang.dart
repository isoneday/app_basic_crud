import 'package:flutter/material.dart';
import 'package:flutter_app/network/kominfo_network.dart';
import 'package:path/path.dart' as path;
import 'barang.dart';

class ModelListBarang with ChangeNotifier {
  String? pesan;
  bool? sukses;
  List<Barang>? barang = [];
  List<Barang>? get listBarang => barang;
  KominfoNetwork network = KominfoNetwork();
  ModelListBarang({this.pesan, this.sukses, this.barang});

  ModelListBarang? _responseRequest;
  ModelListBarang? get responseRequest => _responseRequest;

  ModelListBarang.fromJson(Map<String, dynamic> json) {
    pesan = json['pesan'];
    sukses = json['sukses'];
    if (json['barang'] != null) {
      barang = [];
      json['barang'].forEach((v) {
        barang?.add(new Barang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pesan'] = this.pesan;
    data['sukses'] = this.sukses;
    if (this.barang != null) {
      data['barang'] = this.barang?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future insertBarangProvider(nama, harga, url, detail) async {
    final response = await network.insertBarang(nama, harga, url, detail);

    Barang dataBarang = Barang();
    dataBarang.barangNama = nama;
    dataBarang.barangHarga = harga;
    dataBarang.barangGambar = path.basename(url) ?? "";
    dataBarang.barangDetail = detail;
    listBarang?.add(dataBarang);
    //untuk melakukan update perubahan dari state data model
    notifyListeners();
    return response;
  }

  Future<void> getBarang() async {
    barang = await network.getListBarang();
    notifyListeners();
  }

  List<Barang> get favoriteItems {
    return listBarang!.where((element) => element.isFavorite).toList();
  }

  Barang findByid(String? id) {
    return listBarang!.firstWhere((element) => element.barangId == id,
        orElse: () => Barang());
  }

  //delete barang
  // Future<ModelListBarang> deleteBarang(id) async {
  //   final response = await network.deleteBarang(id);
  //   _responseRequest = response;
  //   barang?.removeWhere((element) => element.barangId == id);

  //   notifyListeners();
  //   return response;
  // }

  //update product
  Future updateProductProvider(id, nama, harga, url, detail) async {
    final response = await network.updateProduct(id, nama, harga, url, detail);
    // _responseRequest = response;

    var index = listBarang?.indexWhere((element) => element.barangId == id);

    listBarang?[index!] = Barang(
        barangId: id,
        barangNama: nama,
        barangHarga: harga,
        barangGambar: path.basename(url),
        barangDetail: detail);
    notifyListeners();
    return response;
  }

  // Future<ModelListBarang> updateProductTanpagmbar(
  //     id, nama, harga, gambar, detail) async {
  //   final response =
  //       await network.updateBarangTanpaGambar(id, nama, harga, gambar, detail);
  //   _responseRequest = response;

  //   var index = listBarang?.indexWhere((element) => element.barangId == id);

  //   listBarang?[index!] = Barang(
  //       barangId: id,
  //       barangNama: nama,
  //       barangHarga: harga,
  //       barangGambar: gambar,
  //       barangDetail: detail);
  //   notifyListeners();
  //   return response;
  // }

  // search product
  List<Barang>? _listProductSearch;

  List<Barang>? get listProductSearch => _listProductSearch;
  void searchProduct(String keyword) {
    List<Barang> listSearch = [];
    if (keyword.isEmpty) {
      listSearch.clear();
      _listProductSearch = listSearch;
    } else {
      barang?.forEach((element) {
        if (element.barangNama!.toLowerCase().contains(keyword)) {
          listSearch.add(element);
        }
      });
      _listProductSearch = listSearch;
    }
    notifyListeners();
  }
}
