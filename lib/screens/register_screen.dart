import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue.shade200,
                    Colors.blue.shade700,
                  ],
                )),
            width: double.infinity,
            height: 300,
            child: Image.asset("asset/images/diskominfo.png"),
          ),
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "email",
                    filled: true,
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.amber[700],
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50))),
              )
            ],
          ))
        ],
      ),
    );
  }
}
