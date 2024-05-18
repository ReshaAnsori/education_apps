import 'package:education_apps/core/common/views/loading_screen.dart';
import 'package:education_apps/core/common/widgets/gradient_widget.dart';
import 'package:education_apps/core/utils/colours.dart';
import 'package:education_apps/core/utils/media_res.dart';
import 'package:education_apps/src/onboarding/domain/entities/page_content.dart';
import 'package:education_apps/src/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_apps/src/onboarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const pageRoute = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserFirstTimerHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainerWidget(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatusState && !state.isFirstTimer) {
              Navigator.pushNamed(context, '/home');
            } else if (state is UserCachedState) {
              // TODO(user-Cached-Handler): Push to the appropiate screen
            }
          },
          builder: (BuildContext context, OnBoardingState state) {
            if (state is CheckingIfUserIsFirstTimerState ||
                state is CachingFirstTimerState) {
              return const LoadingScreen();
            }

            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
