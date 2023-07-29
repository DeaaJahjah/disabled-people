// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Charity _$CharityFromJson(Map<String, dynamic> json) => Charity(
      id: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      services: json['services'] as String,
      image: json['image'] as String?,
      userType: $enumDecode(_$UserTypeEnumMap, json['user_type']),
    );

Map<String, dynamic> _$CharityToJson(Charity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'location': instance.location,
      'image': instance.image,
      'user_type': _$UserTypeEnumMap[instance.userType]!,
      'services': instance.services,
    };

const _$UserTypeEnumMap = {
  UserType.patient: 'patient',
  UserType.charityOrg: 'charityOrg',
  UserType.benefactor: 'benefactor',
};
