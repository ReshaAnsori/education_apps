import 'package:education_apps/core/usecase/usecase.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/domain/repos/auth_repository.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  ForgotPassword(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
