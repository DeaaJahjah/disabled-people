import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip.g.dart';

@JsonSerializable(explicitToJson: true)
class Tip extends Equatable {
  final String? id;
  final String containt;
  @JsonKey(name: 'disease_name')
  final String diseaseName;

  const Tip({
    this.id,
    required this.containt,
    required this.diseaseName,
  });

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);

  factory Tip.fromFirestore(DocumentSnapshot documentSnapshot) {
    Tip tip = Tip.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    tip = tip.copyWith(id: documentSnapshot.id);
    return tip;
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'containt': containt,
        'disease_name': diseaseName,
      };

  Tip copyWith({String? id, String? containt, String? diseaseName}) {
    return Tip(id: id ?? this.id, containt: containt ?? this.containt, diseaseName: diseaseName ?? this.diseaseName);
  }

  @override
  List<Object?> get props => throw [id, containt, diseaseName];
}
