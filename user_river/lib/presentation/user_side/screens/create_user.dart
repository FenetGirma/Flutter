
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zemnanit/presentation/user_side/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/user_side/models/auth_state.dart';
import 'package:zemnanit/presentation/user_side/providers/auth_provider.dart';
import 'package:zemnanit/presentation/user_side/services/auth_service.dart';

class CreateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const User();
  }
}

class User extends ConsumerStatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  ConsumerState<User> createState() => _UserState();
}

class _UserState extends ConsumerState<User> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider.notifier);
    final authState = ref.watch(authServiceProvider);

    ref.listen<AuthState>(authServiceProvider, (previous, next) {
      print('State changed: ${next.message}, loading: ${next.loading}, error: ${next.error}');
      if (!next.loading && next.message == "User created successfully") {
        Navigator.of(context, rootNavigator: true).pushNamed("/login");
      } else if (!next.loading && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed. Please try again.')),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF1CFC3),
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  children: const [
                    Text(
                      "Full Name:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                    labelText: "Enter your Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Email:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Age:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: "Enter your age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Password:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Confirm Password:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: "Confirm your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: authState.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 138, 60, 60),
                          ),
                        ),
                        onPressed: () async {
                          final String fullname = fullnameController.text;
                          final String email = emailController.text;
                          final String age = ageController.text;
                          final String password = passwordController.text;

                          print('Button pressed: fullname: $fullname, email: $email, age: $age');
                          // Call the create user function from the auth service
                          await authService.signup(
                            email,
                            password,
                            fullname,
                            age,
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Already have an account? Log in here.",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login_admin');
                },
                child: const Text(
                  "Log in as Admin",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
