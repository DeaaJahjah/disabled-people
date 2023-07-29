import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_message.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderMessage extends Equatable {
  @JsonKey(name: 'order_id')
  final String orderId;
  final String text;
  final String status;
  @JsonKey(name: 'deliverd_date')
  final DateTime deliverdDate;
  final String location;

  const OrderMessage(
      {required this.status,
      required this.orderId,
      required this.text,
      required this.deliverdDate,
      required this.location});

  factory OrderMessage.fromJson(Map<String, dynamic> json) => _$OrderMessageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMessageToJson(this);

  @override
  List<Object?> get props => [orderId, text, deliverdDate, location];
}
