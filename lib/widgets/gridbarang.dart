import 'package:flutter/material.dart';
import 'package:flutter_app/providers/model_listbarang.dart';
import 'package:provider/provider.dart';

import '../model/model_listbarang.dart';
import '../providers/barang.dart';
import 'itembarang.dart';

class GridBarang extends StatelessWidget {
   GridBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelListBarang>(builder: (context, data, _) {
      final product = data.listBarang;

      return GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: product?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: product?[index],
                child: ItemBarang(),
              ));
    });
  }
}
