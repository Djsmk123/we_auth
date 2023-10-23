import 'package:equatable/equatable.dart';

class Usermodel extends Equatable {
  final int id;
  final String username;
  final String email;
  final String publicProfileImage;
  final String privateProfileImage;
  final String createdAt;
  final String updatedAt;

  const Usermodel(
      {required this.id,
      required this.username,
      required this.email,
      required this.publicProfileImage,
      required this.privateProfileImage,
      required this.createdAt,
      required this.updatedAt});

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        publicProfileImage: json['public_profile_image'],
        privateProfileImage: json['private_profile_image'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'public_profile_image': publicProfileImage,
      'private_profile_image': privateProfileImage,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        publicProfileImage,
        privateProfileImage,
        createdAt,
        updatedAt
      ];
  String getUserName() => username.split("@").first;
}
