import 'package:flutter/material.dart';
import 'package:flutter_app/model/model_listbarang.dart';
import 'package:flutter_app/util/constants.dart';

class ItemBarang extends StatelessWidget {
  Barang? barang;
  ItemBarang({Key? key, this.barang});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(
            Gambar + barang!.barangGambar!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.blue.shade200,
            title: Text(barang!.barangNama!),
          ),
        ));
  }
}
