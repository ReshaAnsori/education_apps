import 'package:education_apps/core/extentions/context_ext.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const pageRoute = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'I am Dashboard Screen',
          style: context.theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
