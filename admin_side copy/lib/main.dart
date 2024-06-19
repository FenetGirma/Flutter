import 'package:admin_side/Application/login_page/login_bloc.dart';
import 'package:admin_side/Infrastructure/Respositories/login_repository.dart';
import 'package:admin_side/Presentation/login_admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  final httpClient = http.Client();
  final loginRepository = LoginRepository(httpClient: httpClient);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                AdminLoginBloc(loginRepository: loginRepository)),
      ],
      child: MaterialApp(
        home: AdminLoginPage(),
      ),
    ),
  );
}
