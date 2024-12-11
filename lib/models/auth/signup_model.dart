import 'package:project_flutter_football/models/model_protocol.dart';

class UserSignUpModel extends ModelProtocol {
  final String email;
  final String? lastName;
  final String name;
  final String? phone;
  final String role;
  final String password;

  UserSignUpModel({
    required this.email,
    this.lastName,
    required this.password,
    required this.name,
    this.phone,
    required this.role,
  });

  // Factory constructor for creating a User from a JSON map
  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
      email: json["email"] as String,
      lastName: json["last_name"] as String?,
      password: json["password"] as String,
      name: json["name"] as String,
      phone: json["phone"] as String?,
      role: json["role"] as String,
    );
  }

  // Method for converting a User object to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "last_name": lastName ?? "unset",
      "name": name,
      "phone": phone ?? "unset",
      "role": role ?? "unset",
      "password": password
    };
  }
}


class SendOTP extends ModelProtocol {
  final String email;

  SendOTP({required this.email});

  // Factory constructor for creating a User from a JSON map
  factory SendOTP.fromJson(Map<String, dynamic> json) {
    return SendOTP(
      email: json['email'] as String,
    );
  }

  // Method for converting a User object to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}




class VerifyOTA extends ModelProtocol {
  final String code;
  final String email;

  VerifyOTA({required this.code, required this.email});

  // Factory constructor for creating a VerifyOTA from a JSON map
  factory VerifyOTA.fromJson(Map<String, dynamic> json) {
    return VerifyOTA(
      code: json['code'] as String,
      email: json['email'] as String,
    );
  }

  // Method for converting a VerifyOTA object to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'email': email,
    };
  }
}



class Message extends ModelProtocol {
  final String message;

  Message({required this.message});

  // Factory constructor for creating a Message from a JSON map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'] as String,
    );
  }

  // Method for converting a Message object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}


