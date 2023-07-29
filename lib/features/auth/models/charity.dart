import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charity.g.dart';

@JsonSerializable(explicitToJson: true)
class Charity extends UserModle with EquatableMixin {
  String services;
  Charity(
      {super.id,
      required super.email,
      required super.name,
      required super.password,
      required super.phoneNumber,
      required super.location,
      required this.services,
      super.image,
      required super.userType});
  factory Charity.fromJson(Map<String, dynamic> json) => _$CharityFromJson(json);

  Map<String, dynamic> toJson() => _$CharityToJson(this);

  factory Charity.fromFirestore(DocumentSnapshot documentSnapshot) {
    Charity charity = Charity.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    charity.id = documentSnapshot.id;
    return charity;
  }

  Charity copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? location,
    String? services,
    String? image,
    UserType? userType,
  }) {
    return Charity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      services: services ?? this.services,
      image: image ?? this.image,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [id, name, password, email, phoneNumber, location, services];
}
