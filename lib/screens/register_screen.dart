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
      resizeToAvoidBottomInset: false,
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  validator: validasiEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.amber.shade700,
                          fontWeight: FontWeight.bold),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.orange[700],
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: validasiPassword,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.orange[700],
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: validasiFullName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Full Name",
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.orange[700],
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    validator: validasiPhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Phone",
                        filled: true,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.orange[700],
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  String? validasiEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!.trim())) {
      return 'Enter Valid Email';
    }
    return null;
  }

  String? validasiPassword(String? value) {
    if (value!.length < 6) {
      return ' password harus lebih besar dari 5 karakter';
    }
    return null;
  }

  String? validasiFullName(String? value) {
    if (value!.length < 3) {
      return ' FullName harus lebih besar dari 2 karakter';
    }
    return null;
  }

  String? validasiPhone(String? value) {
    if (value!.length < 11) {
      return ' Phone harus lebih besar dari 10 karakter';
    }
    return null;
  }
}
