import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient extends UserModle with EquatableMixin {
  final DateTime birhday;
  Disease? disease;
  Patient(
      {super.id,
      required super.email,
      required super.name,
      required super.password,
      required super.phoneNumber,
      required super.location,
      required this.birhday,
      this.disease,
      super.image,
      required super.userType});

  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);

  factory Patient.fromFirestore(DocumentSnapshot documentSnapshot) {
    Patient patient = Patient.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    patient.id = documentSnapshot.id;
    return patient;
  }

  Patient copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? location,
    DateTime? birhday,
    Disease? disease,
    String? image,
    UserType? userType,
  }) {
    return Patient(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      birhday: birhday ?? this.birhday,
      disease: disease ?? this.disease,
      image: image ?? this.image,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [id, name, password, email, phoneNumber, location, birhday, disease];
}

@JsonSerializable(explicitToJson: true)
class Disease extends Equatable {
  final String? id;
  final String name;
  final String doc;
  @JsonKey(name: 'health_tips')
  final List<String>? healthTips;

  const Disease({this.id, required this.name, required this.doc, this.healthTips});

  factory Disease.fromJson(Map<String, dynamic> json) => _$DiseaseFromJson(json);
  Map<String, dynamic> toJson() => _$DiseaseToJson(this);

  @override
  List<Object?> get props => [name, doc, healthTips];
}
