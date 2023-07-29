import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'benefactor.g.dart';

@JsonSerializable(explicitToJson: true)
class Benefactor extends UserModle with EquatableMixin {
  final DateTime birhday;
  Benefactor(
      {super.id,
      required super.email,
      required super.name,
      required super.password,
      required super.phoneNumber,
      required super.location,
      required this.birhday,
      required super.image,
      required super.userType});

  factory Benefactor.fromJson(Map<String, dynamic> json) => _$BenefactorFromJson(json);

  Map<String, dynamic> toJson() => _$BenefactorToJson(this);

  factory Benefactor.fromFirestore(DocumentSnapshot documentSnapshot) {
    Benefactor benefactor = Benefactor.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    benefactor.id = documentSnapshot.id;
    return benefactor;
  }

  Benefactor copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? location,
    DateTime? birhday,
    String? image,
    UserType? userType,
  }) {
    return Benefactor(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      birhday: birhday ?? this.birhday,
      image: image ?? this.image,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [id, name, password, email, phoneNumber, location, birhday];
}
