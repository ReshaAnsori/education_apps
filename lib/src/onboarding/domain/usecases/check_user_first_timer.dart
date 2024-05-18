import 'package:education_apps/core/usecase/usecase.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/onboarding/domain/repositores/on_boarding_repository.dart';

class CheckIfUserFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserFirstTimer();
}
