import 'package:dartz/dartz.dart';
import 'package:education_apps/core/errors/exceptions.dart';
import 'package:education_apps/core/errors/failures.dart';
import 'package:education_apps/core/src/onboarding/domain/repositores/on_boarding_repository.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/onboarding/data/datasorce/on_boarding_local_source.dart';

class OnBoardingImpl implements OnBoardingRepo {
  OnBoardingImpl(this._localSource);

  final OnBoardingLocalSource _localSource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<void> checkIfUserFirstTimer() {
    // TODO: implement checkIfUserFirstTimer
    throw UnimplementedError();
  }
}
