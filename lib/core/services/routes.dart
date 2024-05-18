import 'package:education_apps/core/common/views/under_construction_screen.dart';
import 'package:education_apps/core/services/injection_container.dart';
import 'package:education_apps/src/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_apps/src/onboarding/presentation/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generatedRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.pageRoute:
      return _pageRouteBuilder(
        (_) => BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
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
