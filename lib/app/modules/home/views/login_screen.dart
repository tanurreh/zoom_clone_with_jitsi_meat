import 'package:clone_zoom/app/data/assets_path.dart';
import 'package:clone_zoom/app/modules/home/controllers/auth_controller.dart';
import 'package:clone_zoom/app/modules/home/views/home_page.dart';
import 'package:clone_zoom/app/modules/home/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Start or join a meeting',
            style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset(CustomAssets.zoom),
          ),
          CustomButton(
            text: 'Google Sign In',
            onPressed: () async {
              bool res = await AuthController.instance.signInWithGoogle();
              if (res) {
                Get.offAll(() => HomeScreen());
              }
            },
          ),
        ],
      ),
    );
  }
}
