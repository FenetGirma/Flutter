import 'package:admin_side/Application/user_managment/user_bloc.dart';
import 'package:admin_side/Infrastructure/Respositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'user_bloc_test.mocks.dart';

// Annotation to generate the mock files
@GenerateMocks([UserRepository])
void main() {
  group('UserBloc Tests', () {
    late MockUserRepository mockUserRepository;
    late UserBloc userBloc;
    const String accessToken = 'dummy_token';

    setUp(() {
      mockUserRepository = MockUserRepository();
      userBloc = UserBloc(
          userRepository: mockUserRepository, accessToken: accessToken);
    });

    test('Initial values are correct', () {
      expect(userBloc.isLoading, false);
      expect(userBloc.errorMessage, '');
      expect(userBloc.users, []);
    });

    test('Fetch users successfully', () async {
      final users = [
        {'email': 'user1@example.com', 'role': 'user'},
        {'email': 'user2@example.com', 'role': 'admin'},
      ];
      when(mockUserRepository.fetchUsers(accessToken))
          .thenAnswer((_) async => users);

      final fetchFuture = userBloc.fetchUsers();

      expect(userBloc.isLoading, true);
      expect(userBloc.errorMessage, '');

      await fetchFuture;

      expect(userBloc.isLoading, false);
      expect(userBloc.users, users);
      expect(userBloc.errorMessage, '');
    });

    test('Fetch users failure', () async {
      when(mockUserRepository.fetchUsers(accessToken))
          .thenAnswer((_) async => throw Exception('Fetch error'));

      final fetchFuture = userBloc.fetchUsers();

      expect(userBloc.isLoading, true);
      expect(userBloc.errorMessage, '');

      await fetchFuture;

      expect(userBloc.isLoading, false);
      expect(userBloc.users, []);
      expect(userBloc.errorMessage,
          'Error fetching users: Exception: Fetch error');
    });

    test('Update user role successfully', () async {
      final users = [
        {'email': 'user1@example.com', 'role': 'user'},
        {'email': 'user2@example.com', 'role': 'admin'},
      ];
      when(mockUserRepository.fetchUsers(accessToken))
          .thenAnswer((_) async => users);
      await userBloc.fetchUsers();

      when(mockUserRepository.updateUserRole(
              accessToken, 'user1@example.com', 'admin'))
          .thenAnswer((_) async => Future.value());

      await userBloc.updateUserRole('user1@example.com', 'admin');

      expect(userBloc.users[0]['role'], 'admin');
    });

    test('Update user role failure', () async {
      final users = [
        {'email': 'user1@example.com', 'role': 'user'},
        {'email': 'user2@example.com', 'role': 'admin'},
      ];
      when(mockUserRepository.fetchUsers(accessToken))
          .thenAnswer((_) async => users);
      await userBloc.fetchUsers();

      when(mockUserRepository.updateUserRole(
              accessToken, 'user1@example.com', 'admin'))
          .thenThrow(Exception('Update error'));

      await userBloc.updateUserRole('user1@example.com', 'admin');

      expect(userBloc.errorMessage,
          'Error updating user role: Exception: Update error');
    });

    test('Delete user successfully', () async {
      final users = [
        {'email': 'user1@example.com', 'role': 'user'},
        {'email': 'user2@example.com', 'role': 'admin'},
      ];
      when(mockUserRepository.fetchUsers(accessToken))
          .thenAnswer((_) async => users);
      await userBloc.fetchUsers();

      when(mockUserRepository.deleteUser(accessToken, 'user1@example.com'))
          .thenAnswer((_) async => Future.value());

      await userBloc.deleteUser('user1@example.com');

      expect(userBloc.users.length, 1);
      expect(userBloc.users[0]['email'], 'user2@example.com');
    });

    test('Delete user failure', () async {
      final users = [
        {'email': 'user1@example.com', 'role': 'user'},
        {'email': 'user2@example.com', 'role': 'admin'},
      ];
      when(mockUserRepository.fetchUsers(accessToken))
          .thenAnswer((_) async => users);
      await userBloc.fetchUsers();

      when(mockUserRepository.deleteUser(accessToken, 'user1@example.com'))
          .thenThrow(Exception('Delete error'));

      await userBloc.deleteUser('user1@example.com');

      expect(userBloc.errorMessage,
          'Error deleting user: Exception: Delete error');
    });
  });
}
