import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit_tutorial/core/constraints/constraints.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: null,
        icon: Image.asset(
          Constants.googlePath,
          width: 35,
        ),
        label: Text(
          "Open With Google",
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
