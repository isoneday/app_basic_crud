import 'package:flutter/material.dart';
import 'package:flutter_app/screens/barang_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

//membuat halaman splash
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: SessionClass(),
        duration: 3000,
        imageSize: 130,
        imageSrc: "asset/images/logo.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}

class SessionClass extends StatefulWidget {
  const SessionClass({super.key});

  @override
  State<SessionClass> createState() => _SessionClassState();
}

class _SessionClassState extends State<SessionClass> {
  @override
  void initState() {
    checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> checkSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool login = preferences.getBool("sesi") ?? false;
    if (login) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BarangScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
