import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/core/common/sign_in_button.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';

import '../../../core/constants/constraints.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoadig = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            Constants.logoPath,
            height: 40,
          ),
        ),
        actions: const [
          TextButton(
              onPressed: null,
              child: Text(
                "Skip",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ))
        ],
      ),
      body: isLoadig
          ? const Loader()
          : Column(children: [
              SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  "Dive into Anything",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  Constants.loginEmotePath,
                  height: 400, //provided this to fix a constant value.
                ),
              ),
              const SignInButton()
            ]),
    );
  }
}
