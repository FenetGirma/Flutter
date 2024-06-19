
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';

final authServiceProvider = StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService(client: http.Client());
});
