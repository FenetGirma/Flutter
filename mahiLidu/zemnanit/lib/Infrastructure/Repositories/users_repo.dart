import 'package:mongo_dart/mongo_dart.dart';
import 'package:zemnanit/Infrastructure/Models/user_Model.dart';

class UsersRepository {
  final Db _db;
  final DbCollection _usersCollection;

  UsersRepository(this._db) : _usersCollection = _db.collection('users');

  Future<List<User>> getUsers() async {
    final userDocuments = await _usersCollection.find().toList();
    return userDocuments.map((doc) => _mapDocumentToUser(doc)).toList();
  }

  Future<User> createUser(User user) async {
    final userDocument = _mapUserToDocument(user);
    final id = await _usersCollection.insert(userDocument);
    return user.copyWith(id: id.toString());
  }

  Future<User> updateUser(User user) async {
    final userDocument = _mapUserToDocument(user);
    await _usersCollection.updateOne(
        where.id(ObjectId.fromHexString(user.id!)), userDocument);
    return user;
  }

  Future<void> deleteUser(User user) async {
    await _usersCollection
        .deleteOne(where.id(ObjectId.fromHexString(user.id!)));
  }

  User _mapDocumentToUser(Map<String, dynamic> document) {
    return User(
      id: document['_id'].toString(),
      fullname: document['fullname'],
      age: document['age'],
      email: document['email'],
      password: document['password'],
      role: document['role'],
      createdAt: DateTime.parse(document['createdAt'].toString()),
      updatedAt: DateTime.parse(document['updatedAt'].toString()),
    );
  }

  Map<String, dynamic> _mapUserToDocument(User user) {
    return {
      'fullname': user.fullname,
      'age': user.age,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'createdAt': user.createdAt?.toIso8601String(),
      'updatedAt': user.updatedAt?.toIso8601String(),
    };
  }
}
