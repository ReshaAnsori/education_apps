// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

class LoadingState extends AuthState {
  const LoadingState();
}

class ErrorState extends AuthState {
  const ErrorState(
    this.errorMessage,
  );

  final String errorMessage;
}

class SignedInState extends AuthState {
  const SignedInState(
    this.user,
  );

  final LocalUser user;
}

class SignedUpState extends AuthState {
  const SignedUpState();
}

class ForgotPasswordSentState extends AuthState {
  const ForgotPasswordSentState();
}

class UserUpdatedState extends AuthState {
  const UserUpdatedState();
}
