import 'package:json_annotation/json_annotation.dart';

part 'purchase.g.dart';

@JsonSerializable(checked: true)
class Purchase {
  final int id;
  final String status;

  const Purchase({this.id, this.status});

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}
