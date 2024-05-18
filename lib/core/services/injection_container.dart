import 'package:education_apps/src/onboarding/data/datasorce/on_boarding_local_source.dart';
import 'package:education_apps/src/onboarding/data/implementations/on_boarding_implementation.dart';
import 'package:education_apps/src/onboarding/domain/repositores/on_boarding_repository.dart';
import 'package:education_apps/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:education_apps/src/onboarding/domain/usecases/check_user_first_timer.dart';
import 'package:education_apps/src/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// initialize
  final prefs = await SharedPreferences.getInstance();

  /// registerFactories
  sl
    ..registerFactory(
      () => OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserFirstTimer: sl()),
    )

    /// registerLazySingletons
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalSource>(
      () => OnBoardingLocalSourceImp(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
