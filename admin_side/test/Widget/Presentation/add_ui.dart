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
      when(mockBloc.formKey).thenReturn(GlobalKey<FormState>());
      when(mockBloc.isLoading).thenReturn(false);
      when(mockBloc.uploadedImagePath).thenReturn('');
      when(mockBloc.pictureResult).thenReturn(null);

      await buildAddSalonScreen(tester);

      // Enter valid data in form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'Salon Test');
      await tester.enterText(find.byType(TextFormField).at(1), 'Location Test');

      // Tap on 'Select Picture' button
      await tester.tap(find.text('Select Picture'));
      await tester.pumpAndSettle();

      // Verify that pickPicture method is called
      verify(mockBloc.pickPicture(any)).called(1);

      // Tap on 'Submit' button
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify that submitForm method is called
      verify(mockBloc.submitForm(any, 'dummy_token')).called(1);
    });
  });
}
