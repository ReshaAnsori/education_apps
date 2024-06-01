import 'package:education_apps/core/common/views/under_construction_screen.dart';
import 'package:education_apps/core/extentions/context_ext.dart';
import 'package:education_apps/core/services/injection_container.dart';
import 'package:education_apps/core/utils/constants/constant_shared_pref.dart';
import 'package:education_apps/src/authentication/data/model/user_model.dart';
import 'package:education_apps/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_apps/src/authentication/presentation/screens/sign_in_screen.dart';
import 'package:education_apps/src/authentication/presentation/screens/sign_up_screen.dart';
import 'package:education_apps/src/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:education_apps/src/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_apps/src/onboarding/presentation/screens/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> generatedRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final pref = sl<SharedPreferences>();
      return _pageRouteBuilder(
        (context) {
          if (pref.getBool(ConstantSharedPref.firstTimerKey) ?? true) {
            return BlocProvider(
              create: (context) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser;
            final localUser = LocalUserModel(
              uid: user?.uid ?? '',
              email: user?.email ?? '',
              points: 0,
              fullname: user?.displayName ?? '',
            );

            context.userProvider.initUser(localUser);
            return const DashboardScreen();
          }

          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.pageRoute:
      return _pageRouteBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.pageRoute:
      return _pageRouteBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case DashboardScreen.pageRoute :
      return _pageRouteBuilder(
        (_) => const DashboardScreen(),
        settings: settings,
      );
    default:
      return _pageRouteBuilder(
        (_) => const UnderConstructionScreen(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageRouteBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
