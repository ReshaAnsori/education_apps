import 'package:education_apps/core/enums/update_user.dart';
import 'package:education_apps/core/usecase/usecase.dart';
import 'package:education_apps/core/utils/typedefs.dart';
import 'package:education_apps/src/authentication/domain/repos/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  UpdateUser(this._repo);

  final AuthRepository _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.userData,
    required this.action,
  });

  final EnumUpdateUser action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
