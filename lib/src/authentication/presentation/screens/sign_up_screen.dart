import 'package:education_apps/core/extentions/context_ext.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const pageRoute = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'I am Sign Up Screen',
          style: context.theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
