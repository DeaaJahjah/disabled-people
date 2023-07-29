// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMessage _$OrderMessageFromJson(Map<String, dynamic> json) => OrderMessage(
      status: json['status'] as String,
      orderId: json['order_id'] as String,
      text: json['text'] as String,
      deliverdDate: DateTime.parse(json['deliverd_date'] as String),
      location: json['location'] as String,
    );

Map<String, dynamic> _$OrderMessageToJson(OrderMessage instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'text': instance.text,
      'status': instance.status,
      'deliverd_date': instance.deliverdDate.toIso8601String(),
      'location': instance.location,
    };
