import 'package:flutter_test/flutter_test.dart';
import 'package:zemnanit/presentation/user_side/screens/salonss.dart';

void main() {
  group('SalonListScreen', () {
    test('_filterSalons filters salons based on the search query', () {
      // Initialize the state with some sample salons
      final state = SalonListScreenState();
      state.salons = [
        {'name': 'Beauty Salon', 'location': 'Downtown'},
        {'name': 'Hair Studio', 'location': 'Uptown'},
        {'name': 'Nail Spa', 'location': 'Midtown'},
      ];

      // Set the search query
      state.searchController.text = 'Hair';

      // Call the filter function
      state.filterSalons();

      // Verify the filtered salons
      expect(state.filteredSalons.length, 1);
      expect(state.filteredSalons[0]['name'], 'Hair Studio');
    });

    test('_filterSalons returns all salons when search query is empty', () {
      // Initialize the state with some sample salons
      final state = SalonListScreenState();
      state.salons = [
        {'name': 'Beauty Salon', 'location': 'Downtown'},
        {'name': 'Hair Studio', 'location': 'Uptown'},
        {'name': 'Nail Spa', 'location': 'Midtown'},
      ];

      // Set the search query
      state.searchController.text = '';

      // Call the filter function
      state.filterSalons();

      // Verify the filtered salons
      expect(state.filteredSalons.length, 3);
    });

    test('_filterSalons is case insensitive', () {
      // Initialize the state with some sample salons
      final state = SalonListScreenState();
      state.salons = [
        {'name': 'Beauty Salon', 'location': 'Downtown'},
        {'name': 'Hair Studio', 'location': 'Uptown'},
        {'name': 'Nail Spa', 'location': 'Midtown'},
      ];

      // Set the search query
      state.searchController.text = 'beauty';

      // Call the filter function
      state.filterSalons();

      // Verify the filtered salons
      expect(state.filteredSalons.length, 1);
      expect(state.filteredSalons[0]['name'], 'Beauty Salon');
    });
  });
}
