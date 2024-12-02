import 'package:project_flutter_football/models/model_protocol.dart';

class User extends ModelProtocol {
  final String id;
  final bool active;
  final String email;
  final String lastName;
  final String name;
  final String password;
  final String phone;
  final String role;

  User({
    required this.id,
    required this.active,
    required this.email,
    required this.lastName,
    required this.name,
    required this.password,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      active: json['active'] as bool,
      email: json['email'] as String,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'active': active,
      'email': email,
      'last_name': lastName,
      'name': name,
      'password': password,
      'phone': phone,
      'role': role,
    };
  }
}
