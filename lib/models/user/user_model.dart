import 'package:project_flutter_football/models/model_protocol.dart';

class User extends ModelProtocol {
  final String id;
  final bool active;
  final String email;
  final String lastName;
  final String name;
  final String phone;
  final String role;

  User({
    required this.id,
    required this.active,
    required this.email,
    required this.lastName,
    required this.name,
    required this.phone,
    required this.role,
  });


  bool isManager() {
   return role == 'manager';
  }

  bool isUser() {
    return role == 'user';
  }

  bool isOwnResource(String rUserId) {
    return rUserId == id;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      active: (json['active'] != null )? json['active'] as bool : false,
      email: json['email'] as String,
      lastName: (json['last_name'] != null) ? json['last_name'] as String: 'unset',
      name: json['name'] as String,
      phone: (json['phone'] != null) ? json['phone'] as String : 'unset',
      role: json['role'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'active': active ,
      'email': email,
      'last_name': lastName,
      'name': name,
      'phone': phone,
      'role': role,
    };
  }
}
