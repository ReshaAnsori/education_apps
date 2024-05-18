import 'package:education_apps/core/usecase/usecase.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/onboarding/domain/repositores/on_boarding_repository.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepo _repository;

  @override
  ResultFuture<void> call() => _repository.cacheFirstTimer();
}