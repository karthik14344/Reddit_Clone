import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/core/common/sign_in_button.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';

import '../../../core/constants/constants.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // title: Image.asset(
        //   Constants.logoPath,
        //   height: 40,
        // ),
        actions: [
          TextButton(
              onPressed: () => signInAsGuest(ref, context),
              child: const Text(
                "Skip",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(242, 107, 11, 1)),
              ))
        ],
      ),
      body: isLoading
          ? const Loader()
          : Column(children: [
              const SizedBox(
                height: 35,
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "BMU Campus",
                      style: TextStyle(
                        color: Color.fromRGBO(242, 107, 11, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        fontFamily: 'Intel',
                      ),
                    ),
                    Text(
                      "Care",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Intel',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  //Constants.loginEmotePath,
                  "lib/assets/images/welcome.png",
                  height: 400, //provided this to fix a constant value.
                ),
              ),
              const SignInButton()
            ]),
    );
  }
}
