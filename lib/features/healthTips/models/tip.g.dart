// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tip _$TipFromJson(Map<String, dynamic> json) => Tip(
      id: json['id'] as String?,
      containt: json['containt'] as String,
      diseaseName: json['disease_name'] as String,
    );

Map<String, dynamic> _$TipToJson(Tip instance) => <String, dynamic>{
      'id': instance.id,
      'containt': instance.containt,
      'disease_name': instance.diseaseName,
    };
