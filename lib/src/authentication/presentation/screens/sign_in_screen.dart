import 'package:education_apps/core/extentions/context_ext.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const pageRoute = '/sing-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'I am Sign In Screen',
          style: context.theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
