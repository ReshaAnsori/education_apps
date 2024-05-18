import 'package:education_apps/src/colours.dart';
import 'package:education_apps/src/fonts.dart';
import 'package:education_apps/src/services/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generatedRoute,
      title: 'Education Apps',
      theme: ThemeData(
        useMaterial3: true, 
        fontFamily: Fonts.poppins,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
      ),
    );
  }
}