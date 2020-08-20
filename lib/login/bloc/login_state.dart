part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ForgetInitial extends LoginState {}

class ForgetInProgress extends LoginState {}

class ForgetLoaded extends LoginState {
  final String forgetResponse;

  ForgetLoaded(this.forgetResponse);
}

class ForgetFailure extends LoginState {
  final String error;

  const ForgetFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ForgetFailure { error: $error }';
}