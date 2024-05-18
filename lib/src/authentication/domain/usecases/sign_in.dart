import 'package:education_apps/core/usecase/usecase.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/domain/repos/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParams<void, SignInParams> {
  SignIn(this._repo);

  final AuthRepository _repo;
  @override
  ResultFuture<void> call(SignInParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
