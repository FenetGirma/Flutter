
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:zemnanit/presentation/user_side/screens/create_user.dart';
import 'home.dart';

void main() {
  runApp(ProviderScope(child: Login()));
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Log_in(),
    );
  }
}

class Log_in extends ConsumerStatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  ConsumerState<Log_in> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Log_in> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authServiceProvider, (previous, next) {
      if (next.accessToken != null) {
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Home(
                    email: emailController.text.trim(),
                  )),
        );
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    final authState = ref.watch(authServiceProvider);
    final authNotifier = ref.read(authServiceProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zemnanit Beauty Salons',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400]),
            ),
            SizedBox(height: 10),
            Text('Welcome User!',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    key: ValueKey('emailField'), // Added key
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    key: ValueKey('passwordField'), // Added key
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                key: ValueKey('loginButton'), // Added key
                onTap: () async {
                  await authNotifier.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: authState.loading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
