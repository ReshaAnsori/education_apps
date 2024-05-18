import 'package:bloc/bloc.dart';
import 'package:education_apps/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:education_apps/src/onboarding/domain/usecases/check_user_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserFirstTimer checkIfUserFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserFirstTimer = checkIfUserFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserFirstTimer _checkIfUserFirstTimer;

  Future<void> cacheFirstTimerHandler() async {
    final result = await _cacheFirstTimer();

    result.fold(
      (l) => emit(OnBoardingErrorState(message: l.errorMessage)),
      (_) => emit(const UserCachedState()),
    );
  }

  Future<void> checkIfUserFirstTimerHandler() async {
    final result = await _checkIfUserFirstTimer();

    result.fold(
      (l) => emit(const OnBoardingStatusState(isFirstTimer: true)),
      (r) => emit(OnBoardingStatusState(isFirstTimer: r)),
    );
  }
}
