import 'package:flutter/material.dart';
import 'package:flutter_app/network/kominfo_network.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../argument/data_argument.dart';
import '../model/model_listbarang.dart';
import '../providers/barang.dart';
import '../providers/model_listbarang.dart';
import '../widgets/gridbarang.dart';
import 'addupdate_screen.dart';

class BarangScreen extends StatelessWidget {
  static String id = "barang";
  BarangScreen({super.key});
  KominfoNetwork kominfoNetwork = KominfoNetwork();
  List<Barang>? barang;

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kominfo Jambi"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(
                onPressed: () async {
                  await logoutApp(context);
                },
                icon: Icon(Icons.close)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddUpdateScreen.id,
                arguments: DataArgument(null, false));
          },
          child: Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<ModelListBarang>(context, listen: false).getBarang(),
          child: FutureBuilder(
            future: Provider.of<ModelListBarang>(context, listen: false)
                .getBarang(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridBarang();
            },
          ),
        ),
      ),
    );
  }

  Future<void> logoutApp(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to LogOut this App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              preferences.clear();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

  // Future<List<Barang>?> getData() async {
  //   barang = await kominfoNetwork.getListBarang();
  //   return barang;
  // }
}
