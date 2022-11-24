import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarangScreen extends StatelessWidget {
  const BarangScreen({super.key});

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
        // body: ,
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }
}
