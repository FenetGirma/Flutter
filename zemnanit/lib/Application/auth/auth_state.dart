import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final bool loading;

  const AuthLoading({required this.loading});

  @override
  List<Object> get props => [loading];
}

class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthLoginSuccess extends AuthState {
  final String message;
  final String email;
  final String access_token;

  const AuthLoginSuccess({
    required this.message,
    required this.email,
    required this.access_token,
  });

  @override
  List<Object> get props => [message, email, access_token];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}
