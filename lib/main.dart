import 'package:flutter/material.dart';
import 'package:flutter_ml/splashscreen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MlApp());
}

class MlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
