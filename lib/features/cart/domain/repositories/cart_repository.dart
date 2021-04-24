import 'package:amazing_shoppingcart/features/cart/domain/entities/cart.dart';
import 'package:amazing_shoppingcart/features/cart/domain/entities/product.dart';

abstract class CartRepository {
  Future<Cart> init();
  Future<void> updateCart({Cart cart});
  Future<List<Product>> getProducts();
  Future<void> order({int cartId});
}
