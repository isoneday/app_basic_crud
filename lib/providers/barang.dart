import 'package:flutter/material.dart';

class Barang with ChangeNotifier {
  String? barangId;
  String? barangNama;
  String? barangHarga;
  String? barangGambar;
  String? barangDetail;
  bool isFavorite = false;
  Barang(
      {this.barangId,
      this.barangNama,
      this.barangHarga,
      this.barangGambar,
      this.barangDetail});

  Barang.fromJson(Map<String, dynamic> json) {
    barangId = json['barang_id'];
    barangNama = json['barang_nama'];
    barangHarga = json['barang_harga'];
    barangGambar = json['barang_gambar'];
    barangDetail = json['barang_detail'];
    isFavorite = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barang_id'] = this.barangId;
    data['barang_nama'] = this.barangNama;
    data['barang_harga'] = this.barangHarga;
    data['barang_gambar'] = this.barangGambar;
    data['barang_detail'] = this.barangDetail;
    return data;
  }

  void changeFavStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
