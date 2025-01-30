import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String userName;
  final String fullName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  

  const UserModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    
  });

  // Factory constructor for creating a User instance from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String,
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      role: json['role'] as String,
    );
  }

  // Method for converting a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'id': id,
      'userName': userName,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'role': role,
    };
  }

  @override
  List<Object?> get props => [
        userName,
        email,
        id,
        createdAt,
        updatedAt,
        role,
      ];

  copyWith({required String fullName}) {}
}
