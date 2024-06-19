// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'dart:convert';

// import 'package:zemnanit/presentation/screens/screens/appointments.dart';
// import 'package:zemnanit/presentation/screens/screens/booking.dart';
// import 'package:zemnanit/presentation/screens/screens/home.dart';
// import 'package:zemnanit/presentation/screens/screens/login_user.dart';

// import 'package:zemnanit/presentation/screens/screens/salonss.dart';
// import 'salons_test.mocks.dart';

// @GenerateMocks([http.Client])
// void main() {
//   group('SalonListScreen Widget Tests', () {
//     late MockClient mockClient;
//     late ProviderContainer container;

//     setUp(() {
//       mockClient = MockClient();
//       container = ProviderContainer(
//         overrides: [
//           // Add any overrides for providers if needed
//         ],
//       );
//     });

//     Future<void> pumpSalonListScreenWidget(WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(
//             home: SalonListScreen(),
//           ),
//         ),
//       );
//     }

//     testWidgets('Displays loading indicator while fetching salons', (WidgetTester tester) async {
//       when(mockClient.get(any)).thenAnswer((_) async => http.Response('[]', 200));

//       await pumpSalonListScreenWidget(tester);
//       await tester.pump(); // Initial pump to build the widget tree

//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     });

//     testWidgets('Displays salons list after fetching salons', (WidgetTester tester) async {
//       final salons = [
//         {
//           'name': 'Salon A',
//           'location': 'Location A',
//           'picturePath': 'https://example.com/imageA.jpg',
//         },
//         {
//           'name': 'Salon B',
//           'location': 'Location B',
//           'picturePath': 'https://example.com/imageB.jpg',
//         },
//       ];
//       when(mockClient.get(any)).thenAnswer((_) async => http.Response(jsonEncode(salons), 200));

//       await pumpSalonListScreenWidget(tester);
//       await tester.pump(); // Initial pump to build the widget tree
//       await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

//       expect(find.text('Salon A'), findsOneWidget);
//       expect(find.text('Salon B'), findsOneWidget);
//     });

//     testWidgets('Displays error message on fetch failure', (WidgetTester tester) async {
//       when(mockClient.get(any)).thenThrow(Exception('Failed to fetch salons'));

//       await pumpSalonListScreenWidget(tester);
//       await tester.pump(); // Initial pump to build the widget tree
//       await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

//       expect(find.byType(SnackBar), findsOneWidget);
//       expect(find.text('Failed to load salons'), findsOneWidget);
//     });

//     testWidgets('Filters salons based on search query', (WidgetTester tester) async {
//       final salons = [
//         {
//           'name': 'Salon A',
//           'location': 'Location A',
//           'picturePath': 'https://example.com/imageA.jpg',
//         },
//         {
//           'name': 'Salon B',
//           'location': 'Location B',
//           'picturePath': 'https://example.com/imageB.jpg',
//         },
//       ];
//       when(mockClient.get(any)).thenAnswer((_) async => http.Response(jsonEncode(salons), 200));

//       await pumpSalonListScreenWidget(tester);
//       await tester.pump(); // Initial pump to build the widget tree
//       await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

//       await tester.enterText(find.byType(TextField), 'Salon A');
//       await tester.pumpAndSettle(); // Wait for the filtering to complete

//       expect(find.text('Salon A'), findsOneWidget);
//       expect(find.text('Salon B'), findsNothing);
//     });

//     testWidgets('Navigates to booking screen on button press', (WidgetTester tester) async {
//       final salons = [
//         {
//           'name': 'Salon A',
//           'location': 'Location A',
//           'picturePath': 'https://example.com/imageA.jpg',
//         },
//       ];
//       when(mockClient.get(any)).thenAnswer((_) async => http.Response(jsonEncode(salons), 200));

//       await pumpSalonListScreenWidget(tester);
//       await tester.pump(); // Initial pump to build the widget tree
//       await tester.pumpAndSettle(); // Wait for the asynchronous operations to complete

//       await tester.tap(find.text('Book Here'));
//       await tester.pumpAndSettle(); // Wait for the navigation to complete

//       expect(find.byType(ZemnanitDrop), findsOneWidget);
//     });
//   });
// }
// salon_list_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/screens/salonss.dart';
import 'dart:convert';

import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/bottomnav.dart';


import 'salons_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  testWidgets('SalonListScreen displays salons after successful fetch', (WidgetTester tester) async {
    final salons = [
      {'name': 'Salon A', 'location': 'Location A', 'picturePath': 'https://example.com/pictureA.jpg'},
      {'name': 'Salon B', 'location': 'Location B', 'picturePath': 'https://example.com/pictureB.jpg'},
    ];

    when(mockClient.get(Uri.parse('http://localhost:3000/salons')))
        .thenAnswer((_) async => http.Response(jsonEncode(salons), 200));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((ref) => AuthService(client: mockClient)),
        ],
        child: MaterialApp(
          home: SalonListScreen(),
        ),
      ),
    );

    // Wait for the async fetchSalons method to complete
    await tester.pumpAndSettle();

    expect(find.text('Salon A'), findsOneWidget);
    expect(find.text('Salon B'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('SalonListScreen displays error message on fetch failure', (WidgetTester tester) async {
    when(mockClient.get(Uri.parse('http://localhost:3000/salons')))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((ref) => AuthService(client: mockClient)),
        ],
        child: MaterialApp(
          home: SalonListScreen(),
        ),
      ),
    );

    // Wait for the async fetchSalons method to complete
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed to load salons'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('SalonListScreen filters salons based on search query', (WidgetTester tester) async {
    final salons = [
      {'name': 'Salon A', 'location': 'Location A', 'picturePath': 'https://example.com/pictureA.jpg'},
      {'name': 'Salon B', 'location': 'Location B', 'picturePath': 'https://example.com/pictureB.jpg'},
    ];

    when(mockClient.get(Uri.parse('http://localhost:3000/salons')))
        .thenAnswer((_) async => http.Response(jsonEncode(salons), 200));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((ref) => AuthService(client: mockClient)),
        ],
        child: MaterialApp(
          home: SalonListScreen(),
        ),
      ),
    );

    // Wait for the async fetchSalons method to complete
    await tester.pumpAndSettle();

    expect(find.text('Salon A'), findsOneWidget);
    expect(find.text('Salon B'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Location A');
    await tester.pumpAndSettle();

    expect(find.text('Salon A'), findsOneWidget);
    expect(find.text('Salon B'), findsNothing);
  });
}
