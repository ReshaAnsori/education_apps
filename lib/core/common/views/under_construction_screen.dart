import 'package:education_apps/core/common/widgets/gradient_widget.dart';
import 'package:education_apps/core/utils/media_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainerWidget(
        image: MediaRes.onBoardingBackground,
        child: Center(
          child: Lottie.asset(
            MediaRes.pageUnderConstruction,
          ),
        ),),
    );
  }
}
