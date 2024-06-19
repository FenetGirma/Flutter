import '../Application/user_managment/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ManageUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);

    // Fetch users when the page is built
    if (userBloc.users.isEmpty) {
      userBloc.fetchUsers();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: userBloc.isLoading
          ? Center(child: CircularProgressIndicator())
          : userBloc.errorMessage.isNotEmpty
              ? Center(child: Text(userBloc.errorMessage))
              : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: userBloc.users.length,
                  itemBuilder: (context, index) {
                    var user = userBloc.users[index];
                    final selectedRole = userBloc.users[index]['role'];

                    return Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(user['email']),
                              subtitle: Text('Role: $selectedRole'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    userBloc.updateUserRole(
                                        user['email'], 'admin');
                                  },
                                  child: Text('Set as Admin'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    userBloc.updateUserRole(
                                        user['email'], 'user');
                                  },
                                  child: Text('Set as User'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton.icon(
                                  icon: Icon(Icons.delete),
                                  label: Text('Delete'),
                                  onPressed: () {
                                    userBloc.deleteUser(user['email']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
