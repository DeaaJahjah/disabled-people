// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      birhday: DateTime.parse(json['birhday'] as String),
      disease: json['disease'] == null
          ? null
          : Disease.fromJson(json['disease'] as Map<String, dynamic>),
      image: json['image'] as String?,
      userType: $enumDecode(_$UserTypeEnumMap, json['user_type']),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'location': instance.location,
      'image': instance.image,
      'user_type': _$UserTypeEnumMap[instance.userType]!,
      'birhday': instance.birhday.toIso8601String(),
      'disease': instance.disease?.toJson(),
    };

const _$UserTypeEnumMap = {
  UserType.patient: 'patient',
  UserType.charityOrg: 'charityOrg',
  UserType.benefactor: 'benefactor',
};

Disease _$DiseaseFromJson(Map<String, dynamic> json) => Disease(
      id: json['id'] as String?,
      name: json['name'] as String,
      doc: json['doc'] as String,
      healthTips: (json['health_tips'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DiseaseToJson(Disease instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'doc': instance.doc,
      'health_tips': instance.healthTips,
    };
