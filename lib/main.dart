import 'package:clone_zoom/app/data/theme.dart';
import 'package:clone_zoom/app/modules/home/controllers/auth_controller.dart';
import 'package:clone_zoom/app/modules/home/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(GetMaterialApp(
    defaultTransition: Transition.rightToLeft,
    debugShowCheckedModeBanner: false,
    title: "Zoom Clone",
    theme: primaryTheme,
    home: LoginScreen(),
  ));
}
