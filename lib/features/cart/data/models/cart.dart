import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
class Cart {
  @JsonKey(name: 'cart_id')
  final int cartId;
  final List<Item> products;

  const Cart({this.cartId, this.products});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable(checked: true)
class Item {
  @JsonKey(name: 'product_id')
  final int productId;
  final int quantity;

  const Item({this.productId, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
