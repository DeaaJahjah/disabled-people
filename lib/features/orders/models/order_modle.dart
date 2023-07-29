import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_modle.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModle extends Equatable {
  final String id;
  final String description;
  final String location;
  @JsonKey(name: 'order_type')
  final OrderType orderType;
  @JsonKey(name: 'order_state')
  final OrderState orderState;
  @JsonKey(name: 'owner_id')
  final String ownerId;
  @JsonKey(name: 'owner_name')
  final String ownerName;
  @JsonKey(name: 'owner_pic')
  final String? ownerPic;
  @JsonKey(name: 'reciver_id')
  final String? reciverId;
  @JsonKey(name: 'deliverd_time')
  final DateTime? deliverdTime;
  final List<String>? images;

  const OrderModle({
    required this.id,
    required this.description,
    required this.location,
    required this.orderType,
    required this.orderState,
    required this.ownerId,
    required this.ownerName,
    required this.ownerPic,
    required this.reciverId,
    required this.images,
    required this.deliverdTime,
  });

  factory OrderModle.fromJson(Map<String, dynamic> json) => _$OrderModleFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModleToJson(this);

  factory OrderModle.fromFirestore(DocumentSnapshot documentSnapshot) {
    print(documentSnapshot.data() as Map<String, dynamic>);
    OrderModle order = OrderModle.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    order = order.copyWith(id: documentSnapshot.id);
    return order;
  }
  OrderModle copyWith({
    String? id,
    String? description,
    String? location,
    OrderType? orderType,
    OrderState? orderState,
    String? ownerId,
    String? ownerPic,
    String? ownerName,
    String? reciverId,
    List<String>? images,
    DateTime? deliverdTime,
  }) {
    return OrderModle(
        id: id ?? this.id,
        description: description ?? this.description,
        location: location ?? this.location,
        orderType: orderType ?? this.orderType,
        orderState: orderState ?? this.orderState,
        ownerId: ownerId ?? this.ownerId,
        ownerPic: ownerPic ?? this.ownerPic,
        reciverId: reciverId ?? this.reciverId,
        images: images ?? this.images,
        deliverdTime: deliverdTime ?? this.deliverdTime,
        ownerName: ownerName ?? this.ownerName);
  }

  @override
  List<Object?> get props =>
      [id, deliverdTime, description, location, orderState, orderType, ownerId, ownerPic, reciverId, images];
}
