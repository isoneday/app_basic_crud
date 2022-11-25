import 'package:flutter/material.dart';
import 'package:flutter_app/model/model_listbarang.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:provider/provider.dart';

import '../providers/barang.dart';
import '../screens/barang_detailscreen.dart';

class ItemBarang extends StatelessWidget {
  ItemBarang({Key? key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Barang>(context, listen: false);

    return GestureDetector(
      onTap: (() => Navigator.pushNamed(context, ProductDetailScreen.id,
          arguments: product.barangId)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: Image.network(
              Gambar + product.barangGambar!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.blue.shade200,
              title: Text(product.barangNama!),
            ),
          )),
    );
  }
}
