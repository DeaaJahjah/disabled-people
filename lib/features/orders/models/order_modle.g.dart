// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_modle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModle _$OrderModleFromJson(Map<String, dynamic> json) => OrderModle(
      id: json['id'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      orderType: $enumDecode(_$OrderTypeEnumMap, json['order_type']),
      orderState: $enumDecode(_$OrderStateEnumMap, json['order_state']),
      ownerId: json['owner_id'] as String,
      ownerName: json['owner_name'] as String,
      ownerPic: json['owner_pic'] as String?,
      reciverId: json['reciver_id'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      deliverdTime: json['deliverd_time'] == null
          ? null
          : DateTime.parse(json['deliverd_time'] as String),
    );

Map<String, dynamic> _$OrderModleToJson(OrderModle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'location': instance.location,
      'order_type': _$OrderTypeEnumMap[instance.orderType]!,
      'order_state': _$OrderStateEnumMap[instance.orderState]!,
      'owner_id': instance.ownerId,
      'owner_name': instance.ownerName,
      'owner_pic': instance.ownerPic,
      'reciver_id': instance.reciverId,
      'deliverd_time': instance.deliverdTime?.toIso8601String(),
      'images': instance.images,
    };

const _$OrderTypeEnumMap = {
  OrderType.donation: 'donation',
  OrderType.benefit: 'benefit',
};

const _$OrderStateEnumMap = {
  OrderState.available: 'available',
  OrderState.inProgress: 'inProgress',
  OrderState.unavailable: 'unavailable',
};
