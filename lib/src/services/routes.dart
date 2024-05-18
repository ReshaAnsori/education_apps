import 'package:education_apps/core/common/views/under_construction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Route<dynamic> generatedRoute(RouteSettings settings) {
  switch (settings.name) {
    // case OnBoardingScreen.pageRoute:
    //   return _pageRouteBuilder(
    //     (_) => const OnBoardingScreen(),
    //     settings: settings,
    //   );
    default:
      return _pageRouteBuilder(
        (_) => const UnderConstructionScreen(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageRouteBuilder(Widget Function(BuildContext) page,
    {required RouteSettings settings,}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
