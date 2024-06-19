import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullname;
  final String age;

  const SignupRequested({
    required this.email,
    required this.password,
    required this.fullname,
    required this.age,
  });

  @override
  List<Object> get props => [email, password, fullname, age];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
