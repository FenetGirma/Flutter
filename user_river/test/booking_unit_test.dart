// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'booking_unit_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  group('Booking Page Unit Test', () {
    late MockAuthService mockAuthService;
    late ProviderContainer providerContainer;
    late TextEditingController hairstyleController;
    late TextEditingController commentController;

    setUp(() {
      mockAuthService = MockAuthService();
      providerContainer = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWith((ref) => mockAuthService),
        ],
      );
      hairstyleController = TextEditingController();
      commentController = TextEditingController();
    });

    tearDown(() {
      providerContainer.dispose();
      hairstyleController.dispose();
      commentController.dispose();
    });

    test('bookSalon method is called with correct data', () async {
      final date = DateTime(2023, 6, 18);
      final time = '1PM';
      final hairstyle = 'Test hairstyle';
      final comment = 'Test comment';

      when(mockAuthService.bookSalon(any, any, any, any))
          .thenAnswer((_) async => true);

      hairstyleController.text = hairstyle;
      commentController.text = comment;

      // Simulate the booking
      await providerContainer.read(authServiceProvider.notifier).bookSalon(
            hairstyle,
            '${date.year}-${date.month}-${date.day}',
            time,
            comment,
          );

      // Verify that bookSalon was called with the correct arguments
      verify(mockAuthService.bookSalon(
        hairstyle,
        '${date.year}-${date.month}-${date.day}',
        time,
        comment,
      )).called(1);
    });
  });
}
