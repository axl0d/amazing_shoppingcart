import 'package:amazing_shoppingcart/features/cart/data/models/models.dart';
import 'package:amazing_shoppingcart/features/cart/domain/entities/cart.dart'
    as Entity;
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
class Cart {
  @JsonKey(name: 'cart_id')
  final int cartId;
  final List<Item> products;

  const Cart({this.cartId, this.products});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  factory Cart.fromEntity(Entity.Cart cart) => Cart(
        cartId: cart.cartId,
        products: cart.products
            .map(
              (i) => Item(
                product: Product(
                  id: i.product.id,
                  image: i.product.image,
                  name: i.product.name,
                  description: i.product.description,
                  sku: i.product.sku,
                  price: i.product.price,
                ),
                quantity: i.quantity,
              ),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable(checked: true, explicitToJson: true)
class Item {
  final Product product;
  final int quantity;

  const Item({this.product, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
