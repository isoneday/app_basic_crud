import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

//membuat halaman splash
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: RegisterScreen(),
        duration: 3000,
        imageSize: 130,
        imageSrc: "asset/images/logo.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}
