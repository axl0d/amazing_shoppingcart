import 'package:tul_shoppingcart/features/cart/domain/entities/cart.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/product.dart';

abstract class CartRepository {
  Future<Cart> init();
  Future<Cart> updateCart({Cart cart});
  Future<List<Product>> getProducts();
  Future<void> order({int cartId});
}
