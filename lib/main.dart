import 'package:education_apps/core/common/app/providers/user_provider.dart';
import 'package:education_apps/core/services/injection_container.dart';
import 'package:education_apps/core/services/routes.dart';
import 'package:education_apps/core/utils/colours.dart';
import 'package:education_apps/core/utils/fonts.dart';
import 'package:education_apps/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
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
      ),
    );
  }
}
