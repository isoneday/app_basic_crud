import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/kominfo_network.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  KominfoNetwork kominfoNetwork = KominfoNetwork();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
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
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
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
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: TextFormField(
                          controller: passwordController,
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
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                            onPressed: () {
                              cekValidasi();
                            },
                            child: Text("Login")),
                      ),
                      loading == true
                          ? const Center(child: CircularProgressIndicator())
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          }),
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account ",
                              style: TextStyle(color: Colors.black),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: 'Sign Up!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
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

  void cekValidasi() {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      kominfoNetwork
          .prosesLogin(
        emailController.text,
        passwordController.text,
      )
          .then((response) async {
        if (response.sukses == true) {
          setState(() {
            loading = false;
          });
          showToast(
            response.pesan!,
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 13.0,
            textStyle: const TextStyle(fontSize: 18.0),
          );
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("sesi", true);
          //untuk perpindahan halaman
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            loading = false;
          });
          showToast(
            response.pesan!,
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 13.0,
            textStyle: const TextStyle(fontSize: 18.0),
          );
        }
      });
    }
  }
}
