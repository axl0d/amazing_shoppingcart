import 'package:amazing_shoppingcart/features/cart/domain/entities/entities.dart';
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

  double get total => products.fold(
      0, (total, current) => total + current.product.price * current.quantity);

  String get totalLabel => total.toStringAsFixed(2);

  @override
  List<Object> get props => [cartId, products];
}

class Item extends Equatable {
  final Product product;
  final int quantity;

  const Item({this.product, this.quantity});

  Item copyWith({
    Product product,
    int quantity,
  }) {
    return Item(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [product, quantity];
}
