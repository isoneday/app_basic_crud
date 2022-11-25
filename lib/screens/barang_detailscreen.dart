import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:provider/provider.dart';

import '../argument/data_argument.dart';
import '../providers/model_listbarang.dart';
import 'addupdate_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static String id = "detail";

  String? productID;
  ProductDetailScreen({Key? key, this.productID = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context).settings.arguments as String;
    final getProduct = Provider.of<ModelListBarang>(context, listen: true)
        ?.findByid(productID);
    final product = Provider.of<ModelListBarang>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(getProduct?.barangNama ?? "nothing"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                product.deleteBarang(productID).then((value) {
                  final scaffold = ScaffoldMessenger.of(context);

                  if (value.sukses == true) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(value.pesan!),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text("gagal menghapusp"),
                      ),
                    );
                  }
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 300,
                width: double.infinity,
                child: getProduct?.barangGambar != null
                    ? CachedNetworkImage(
                        imageUrl: Gambar + getProduct!.barangGambar!,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container()),
            SizedBox(
              height: 10,
            ),
            Text(
              getProduct?.barangHarga ?? "",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: Text(
                getProduct?.barangDetail ?? "detail",
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddUpdateScreen.id,
                    arguments: DataArgument(getProduct, true));
              },
              child: Text("update"),
            )
          ],
        ),
      ),
    );
  }
}
