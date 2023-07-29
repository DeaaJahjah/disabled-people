import 'package:disaoled_people/config/enums/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class UserModle extends Equatable {
  String? id;
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String location;
  final String? image;
  @JsonKey(name: 'user_type')
  final UserType userType;
  UserModle(
      {this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.phoneNumber,
      required this.location,
      required this.image,
      required this.userType});

  @override
  List<Object?> get props => [id, name, password, email, phoneNumber, location];
}
