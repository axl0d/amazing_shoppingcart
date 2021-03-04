// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return $checkedNew('Purchase', json, () {
    final val = Purchase(
      id: $checkedConvert(json, 'id', (v) => v as int),
      status: $checkedConvert(json, 'status', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$PurchaseToJson(Purchase instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };
