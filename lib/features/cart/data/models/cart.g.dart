// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return $checkedNew('Cart', json, () {
    final val = Cart(
      cartId: $checkedConvert(json, 'cart_id', (v) => v as int),
      products: $checkedConvert(
          json,
          'products',
          (v) => (v as List)
              ?.map((e) =>
                  e == null ? null : Item.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    );
    return val;
  }, fieldKeyMap: const {'cartId': 'cart_id'});
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'cart_id': instance.cartId,
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return $checkedNew('Item', json, () {
    final val = Item(
      product: $checkedConvert(
          json,
          'product',
          (v) =>
              v == null ? null : Product.fromJson(v as Map<String, dynamic>)),
      quantity: $checkedConvert(json, 'quantity', (v) => v as int),
    );
    return val;
  });
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'product': instance.product?.toJson(),
      'quantity': instance.quantity,
    };
