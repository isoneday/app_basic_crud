import 'package:flutter/material.dart';

class BarangScreen extends StatelessWidget {
  const BarangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kominfo Jambi"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.close)),
        ],
      ),
      // body: ,
    );
  }
}
