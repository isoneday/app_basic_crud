// class ModelListBarang {
//   String? pesan;
//   bool? sukses;
//   List<Barang>? barang;

//   ModelListBarang({this.pesan, this.sukses, this.barang});

//   ModelListBarang.fromJson(Map<String, dynamic> json) {
//     pesan = json['pesan'];
//     sukses = json['sukses'];
//     if (json['barang'] != null) {
//       barang = <Barang>[];
//       json['barang'].forEach((v) {
//         barang!.add(new Barang.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['pesan'] = this.pesan;
//     data['sukses'] = this.sukses;
//     if (this.barang != null) {
//       data['barang'] = this.barang!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Barang {
//   String? barangId;
//   String? barangNama;
//   String? barangHarga;
//   String? barangGambar;
//   String? barangDetail;

//   Barang(
//       {this.barangId,
//       this.barangNama,
//       this.barangHarga,
//       this.barangGambar,
//       this.barangDetail});

//   Barang.fromJson(Map<String, dynamic> json) {
//     barangId = json['barang_id'];
//     barangNama = json['barang_nama'];
//     barangHarga = json['barang_harga'];
//     barangGambar = json['barang_gambar'];
//     barangDetail = json['barang_detail'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['barang_id'] = this.barangId;
//     data['barang_nama'] = this.barangNama;
//     data['barang_harga'] = this.barangHarga;
//     data['barang_gambar'] = this.barangGambar;
//     data['barang_detail'] = this.barangDetail;
//     return data;
//   }
// }
