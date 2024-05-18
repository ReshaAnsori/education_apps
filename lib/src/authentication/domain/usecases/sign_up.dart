// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:education_apps/core/usecase/usecase.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/domain/repos/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  SignUp(this._repo);

  final AuthRepository _repo;
  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.fullname,
    required this.email,
    required this.password,
  });

  final String email;
  final String fullname;
  final String password;

  @override
  List<Object> get props => [email, fullname, password];
}
