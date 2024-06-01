import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:education_apps/core/enums/update_user.dart';
import 'package:education_apps/src/authentication/domain/entities/user_entity.dart';
import 'package:education_apps/src/authentication/domain/usecases/forgot_password.dart';
import 'package:education_apps/src/authentication/domain/usecases/sign_in.dart';
import 'package:education_apps/src/authentication/domain/usecases/sign_up.dart';
import 'package:education_apps/src/authentication/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateuserEvent>(_updateuserHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (l) => emit(ErrorState(l.errorMessage)),
      (r) => emit(SignedInState(r)),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullname: event.name,
      ),
    );

    result.fold(
      (l) => emit(ErrorState(l.errorMessage)),
      (_) => emit(const SignedUpState()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(event.email);

    result.fold(
      (l) => emit(ErrorState(l.errorMessage)),
      (_) => emit(const ForgotPasswordSentState()),
    );
  }

  Future<void> _updateuserHandler(
    UpdateuserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(
      UpdateUserParams(
        userData: event.userData,
        action: event.action,
      ),
    );

    result.fold(
      (l) => emit(ErrorState(l.errorMessage)),
      (_) => emit(const UserUpdatedState()),
    );
  }
}
