import 'package:tul_shoppingcart/features/cart/data/data_sources/firestore_api_client.dart';
import 'package:tul_shoppingcart/features/cart/data/models/cart.dart'
    as CartModel;
import 'package:tul_shoppingcart/features/cart/domain/entities/cart.dart';
import 'package:tul_shoppingcart/features/cart/domain/entities/product.dart';
import 'package:tul_shoppingcart/features/cart/domain/repositories/cart_repository.dart';

class FireStoreRepository implements CartRepository {
  FireStoreRepository({FireStoreApiClient client})
      : _client = client ?? FireStoreApiClient();

  final FireStoreApiClient _client;

  @override
  Future<Cart> getCart() async {
    final cart = await _client.getCart();
    final items = cart.products
        .map((i) => Item(productId: i.productId, quantity: i.quantity))
        .toList();
    return Cart(products: items, cartId: cart.cartId);
  }

  @override
  Future<Cart> init() async {
    final cart = await _client.init();
    final items = cart.products
        .map((i) => Item(productId: i.productId, quantity: i.quantity))
        .toList();
    return Cart(products: items, cartId: cart.cartId);
  }

  @override
  Future<List<Product>> getProducts() async {
    final products = await _client.getProducts();
    return products
        .map((p) => Product(
              id: p.id,
              image: p.image,
              name: p.name,
              description: p.description,
              sku: p.sku,
            ))
        .toList();
  }

  @override
  Future<Cart> updateCart({Cart cart}) async {
    final cartModel = CartModel.Cart(
        cartId: cart.cartId,
        products: cart.products
            .map((i) =>
                CartModel.Item(productId: i.productId, quantity: i.quantity))
            .toList());
    await _client.updateCart(cartModel);
    return Cart(cartId: cart.cartId, products: cart.products);
  }

  @override
  Future<void> order({int cartId}) async {
    await _client.order(cartId);
  }
}
