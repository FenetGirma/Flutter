// model.dart
class AuthState {
  final String? message;
  final List<dynamic>? appointments;
  final String? error;
  final String? email;
  final String? fullname;
  final String? accessToken;
  final List<dynamic>? salons;
  final bool loading;

  AuthState({
    this.message,
    this.salons,
    this.fullname,
    this.appointments,
    this.error,
    this.email,
    this.accessToken,
    this.loading = false,
  });
}
