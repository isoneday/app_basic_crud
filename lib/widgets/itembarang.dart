import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              imageUrl: Gambar + product!.barangGambar!,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.blue.shade200,
              title: Text(product.barangNama!),
            ),
          )),
    );
  }
}
