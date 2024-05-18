import 'package:education_apps/core/enums/update_user.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  AuthRepository();

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullname,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required EnumUpdateUser action,
    dynamic userData,
  });
}
