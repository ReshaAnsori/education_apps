import 'package:dartz/dartz.dart';
import 'package:education_apps/core/enums/update_user.dart';
import 'package:education_apps/core/errors/exceptions.dart';
import 'package:education_apps/core/errors/failures.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/data/datasource/auth_remote_sorce.dart';
import 'package:education_apps/src/authentication/domain/entities/user_entity.dart';
import 'package:education_apps/src/authentication/domain/repos/auth_repository.dart';

class AuthImplementation extends AuthRepository {
  AuthImplementation(this._dataSource);
  final AuthRemoteSource _dataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _dataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      await _dataSource.signUp(
        email: email,
        fullname: fullname,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required EnumUpdateUser action,
    required dynamic userData,
  }) async {
    try {
      await _dataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
