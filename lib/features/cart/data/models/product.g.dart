// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return $checkedNew('Product', json, () {
    final val = Product(
      id: $checkedConvert(json, 'id', (v) => v as int),
      sku: $checkedConvert(json, 'sku', (v) => v as String),
      name: $checkedConvert(json, 'name', (v) => v as String),
      description: $checkedConvert(json, 'description', (v) => v as String),
      image: $checkedConvert(json, 'image', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
