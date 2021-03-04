import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int cartId;
  final List<Item> products;

  const Cart({this.cartId, this.products});

  Cart copyWith({
    int cartId,
    List<Item> products,
  }) {
    return Cart(
      cartId: cartId ?? this.cartId,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [cartId, products];
}

class Item extends Equatable {
  final int productId;
  final int quantity;

  const Item({this.productId, this.quantity});

  Item copyWith({
    int productId,
    int quantity,
  }) {
    return Item(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [productId, quantity];
}
