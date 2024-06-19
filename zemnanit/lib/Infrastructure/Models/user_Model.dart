class User {
  final String? id;
  final String fullname;
  final int age;
  final String email;
  final String password;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.fullname,
    required this.age,
    required this.email,
    required this.password,
    required this.role,
    this.createdAt,
    this.updatedAt,
  });

  // Add the copyWith method
  User copyWith({
    String? id,
    String? fullname,
    int? age,
    String? email,
    String? password,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      age: age ?? this.age,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
