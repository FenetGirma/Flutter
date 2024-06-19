import 'package:admin_side/Presentation/add_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:admin_side/Application/add_page/add_bloc.dart';
import 'package:provider/provider.dart';

// Annotate with @GenerateMocks and specify the class you want to mock
@GenerateMocks([AddSalonBloc])
import 'add_ui.mocks.dart';

void main() {
  group('AddSalonScreen Tests', () {
    late MockAddSalonBloc mockBloc;

    setUp(() {
      mockBloc = MockAddSalonBloc();
    });

    Future<void> buildAddSalonScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AddSalonBloc>(
            create: (_) => mockBloc,
            child: AddSalonScreen(accessToken: 'dummy_token'),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('should validate and submit form', (WidgetTester tester) async {
      // Set up mock behavior
      when(mockBloc.formKey).thenReturn(GlobalKey<FormState>());
      when(mockBloc.isLoading).thenReturn(false);
      when(mockBloc.uploadedImagePath).thenReturn('');
      when(mockBloc.pictureResult).thenReturn(null);

      // Print to debug the setup
      print('Mock setup completed.');

      // Build the screen
      await buildAddSalonScreen(tester);

      // Enter valid data in form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'Salon Test');
      await tester.enterText(find.byType(TextFormField).at(1), 'Location Test');

      // Verify text input values
      try {
        expect(find.text('Salon Test'), findsOneWidget,
            reason: 'Salon Test text not found');
        expect(find.text('Location Test'), findsOneWidget,
            reason: 'Location Test text not found');
        print('Text input verification passed.');
      } catch (e) {
        print('Expected text not found in text fields.\nError: $e');
        fail('Expected text not found in text fields.\nError: $e');
      }

      // Tap on 'Select Picture' button
      try {
        await tester.tap(find.text('Select Picture'));
        await tester.pumpAndSettle();
        print('Tapped Select Picture button.');
      } catch (e) {
        print('Failed to tap Select Picture button.\nError: $e');
        fail('Failed to tap Select Picture button.\nError: $e');
      }

      // Verify that pickPicture method is called
      try {
        verify(mockBloc.pickPicture(any)).called(1);
        print('pickPicture method called successfully.');
      } catch (e) {
        print(
            'Expected pickPicture to be called once, but it was not.\nError: $e');
        print('Verify the button tap and method call.');
        fail(
            'Expected pickPicture to be called once, but it was not.\nError: $e');
      }

      // Tap on 'Submit' button
      try {
        await tester.tap(find.text('Submit'));
        await tester.pumpAndSettle();
        print('Tapped Submit button.');
      } catch (e) {
        print('Failed to tap Submit button.\nError: $e');
        fail('Failed to tap Submit button.\nError: $e');
      }

      // Verify that submitForm method is called
      try {
        verify(mockBloc.submitForm(any, 'dummy_token')).called(1);
        print('submitForm method called successfully.');
      } catch (e) {
        print(
            'Expected submitForm to be called once, but it was not.\nError: $e');
        fail(
            'Expected submitForm to be called once, but it was not.\nError: $e');
      }
    });
  });
}
