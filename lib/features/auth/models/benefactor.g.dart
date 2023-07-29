// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefactor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Benefactor _$BenefactorFromJson(Map<String, dynamic> json) => Benefactor(
      id: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      birhday: DateTime.parse(json['birhday'] as String),
      image: json['image'] as String?,
      userType: $enumDecode(_$UserTypeEnumMap, json['user_type']),
    );

Map<String, dynamic> _$BenefactorToJson(Benefactor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'location': instance.location,
      'image': instance.image,
      'user_type': _$UserTypeEnumMap[instance.userType]!,
      'birhday': instance.birhday.toIso8601String(),
    };

const _$UserTypeEnumMap = {
  UserType.patient: 'patient',
  UserType.charityOrg: 'charityOrg',
  UserType.benefactor: 'benefactor',
};
