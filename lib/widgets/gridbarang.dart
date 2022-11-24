import 'package:flutter/material.dart';

import '../model/model_listbarang.dart';
import 'itembarang.dart';

class GridBarang extends StatelessWidget {
  List<Barang>? barangTerima;
  GridBarang({super.key, this.barangTerima});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: barangTerima?.length ?? 0,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) => ItemBarang(barang: barangTerima?[index]),
    );
  }
}
