import '../../Infrastructure/Respositories/user_repository.dart';
import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier {
  final UserRepository userRepository;
  final String accessToken;
  bool _isLoading = false;
  String _errorMessage = '';
  List _users = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List get users => _users;

  UserBloc({required this.userRepository, required this.accessToken});

  Future<void> fetchUsers() async {
    _setLoading(true);
    _setErrorMessage('');

    try {
      _users = await userRepository.fetchUsers(accessToken);
    } catch (e) {
      _setErrorMessage('Error fetching users: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUserRole(String email, String newRole) async {
    try {
      await userRepository.updateUserRole(accessToken, email, newRole);
      final index = _users.indexWhere((user) => user['email'] == email);
      if (index != -1) {
        _users[index]['role'] = newRole;
        notifyListeners();
      }
    } catch (e) {
      _setErrorMessage('Error updating user role: $e');
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      await userRepository.deleteUser(accessToken, email);
      _users.removeWhere((user) => user['email'] == email);
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Error deleting user: $e');
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
