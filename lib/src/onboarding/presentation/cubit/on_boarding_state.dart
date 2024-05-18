part of 'on_boarding_cubit.dart';

sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

final class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

final class CachingFirstTimerState extends OnBoardingState {
  const CachingFirstTimerState();
}

final class CheckingIfUserIsFirstTimerState extends OnBoardingState {
  const CheckingIfUserIsFirstTimerState();
}

final class UserCachedState extends OnBoardingState {
  const UserCachedState();
}

final class OnBoardingStatusState extends OnBoardingState {
  const OnBoardingStatusState({required this.isFirstTimer});

  final bool isFirstTimer;
}

final class OnBoardingErrorState extends OnBoardingState {
  const OnBoardingErrorState({required this.message});

  final String message;
}
