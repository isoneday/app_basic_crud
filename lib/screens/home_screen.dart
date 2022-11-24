// import library
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
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
          title: Text('Home'),
          // untuk menambahkan icon sebelah kiri text : leading
          leading: Icon(Icons.home),
          actions: [
            IconButton(
                onPressed: () {
                  showToast(
                    'klik icon search',
                    position: ToastPosition.bottom,
                    backgroundColor: Colors.black.withOpacity(0.8),
                    radius: 13.0,
                    textStyle: const TextStyle(fontSize: 18.0),
                  );
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  showToast(
                    'klik icon settings',
                    position: ToastPosition.bottom,
                    backgroundColor: Colors.black.withOpacity(0.8),
                    radius: 13.0,
                    textStyle: const TextStyle(fontSize: 18.0),
                  );
                },
                icon: Icon(Icons.settings)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "asset/images/fluttertraining.jpg",
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Training :",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "Flutter Mobile Apps",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 230, 142, 9)),
                  )
                ],
              ),
              Image.network(
                  "https://repository-images.githubusercontent.com/31792824/fb7e5700-6ccc-11e9-83fe-f602e1e1a9f1"),
              Image.asset(
                "asset/images/fluttertraining.jpg",
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
