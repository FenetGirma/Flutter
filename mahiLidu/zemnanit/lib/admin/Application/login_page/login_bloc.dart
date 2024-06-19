import '../../Infrastructure/Respositories/login_repository.dart';
import '../../Presentation/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminLoginBloc extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginRepository loginRepository;

  AdminLoginBloc({required this.loginRepository});

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loginAdmin(BuildContext context) async {
    _setLoading(true);
    _setErrorMessage('');

    final String email = emailController.text.trim();
    final String password = passwordController.text;

    try {
      final Map<String, dynamic> result =
          await loginRepository.login(email, password);
      final String accessToken = result['accessToken'];

      final Map<String, dynamic> decodedToken =
          loginRepository.decodeToken(accessToken);
      final String? role = decodedToken['role'];

      if (role == 'Admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminDashboard(
              accessToken: accessToken,
              httpClient: http.Client(),
            ),
          ),
        );
      } else {
        _setErrorMessage('You are not authorized to access the admin panel.');
      }
    } catch (error) {
      _setErrorMessage(error.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
