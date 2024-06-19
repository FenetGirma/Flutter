import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import '../services/auth_service.dart';

// Define a StateProvider for the selected index of the BottomNavigationBar
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MyBottomNavigationBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 0 ? Icons.home : Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 1 ? Icons.spa : Icons.spa_outlined,
          ),
          label: 'Salons',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 2
                ? Icons.calendar_today
                : Icons.calendar_today_outlined,
          ),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 3 ? Icons.logout : Icons.logout_outlined,
          ),
          label: 'Log Out',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red[400],
      unselectedItemColor: Colors.black,
      onTap: (index) {
        final authService = ref.read(authServiceProvider.notifier);

        switch (index) {
          case 0:
            Navigator.of(context, rootNavigator: true).pushNamed("/home");

            break;
          case 1:
            Navigator.of(context, rootNavigator: true).pushNamed("/salons");

            break;
          case 2:
            Navigator.of(context, rootNavigator: true)
                .pushNamed("/appointments");

            break;
          case 3:
            authService.logout();
            Navigator.of(context, rootNavigator: true).pushNamed("/login");
            break;
        }
        ref.read(selectedIndexProvider.notifier).state = index;
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
