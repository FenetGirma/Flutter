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


  AuthState copyWith({
    bool? loading,
    String? email,
    String? accessToken,
    String? message,
    String? error,
    List<dynamic>? appointments,
    List<dynamic>? salons,
        // bool? loading,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
      message: message ?? this.message,
      error: error ?? this.error,
      appointments: appointments ?? this.appointments,
      salons: salons ?? this.salons,
     
    );
  }
}
