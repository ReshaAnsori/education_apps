import 'package:education_apps/core/services/injection_container.dart';
import 'package:education_apps/core/services/routes.dart';
import 'package:education_apps/core/utils/colours.dart';
import 'package:education_apps/core/utils/fonts.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
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
