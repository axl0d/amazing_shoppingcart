import 'dart:math';

import 'package:amazing_shoppingcart/features/cart/data/data_sources/firestore_api_client.dart';
import 'package:amazing_shoppingcart/features/cart/data/data_sources/local_data_source.dart';
import 'package:amazing_shoppingcart/features/cart/data/models/models.dart'
    as Models;
import 'package:amazing_shoppingcart/features/cart/domain/entities/entities.dart';
import 'package:amazing_shoppingcart/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class FireStoreRepository implements CartRepository {
  const FireStoreRepository(this._client, this._localDataSource);

  final FireStoreApiClient _client;
  final LocalDataSource _localDataSource;

  @override
  Future<Cart> init() async {
    final purchaseId = _localDataSource.getPurchaseId();
    final purchaseResponse = await _client.getPurchase(purchaseId);
    final cart = purchaseResponse.isEmpty
        ? await createNewCart()
        : await createCartFromPurchase(purchaseResponse);
    final products = cart.products
        .map(
          (i) => Item(
            product: Product(
              id: i.product.id,
              image: i.product.image,
              description: i.product.description,
              sku: i.product.sku,
              name: i.product.name,
              price: i.product.price,
            ),
            quantity: i.quantity,
          ),
        )
        .toList();
    return Cart(products: products, cartId: cart.cartId);
  }

  Future<Models.Cart> createNewCart() async {
    final randomId = Random().nextInt(100);
    final newCart = Models.Cart(cartId: randomId, products: []);
    final cartKey = await _client.createNewCart(newCart);
    final purchaseKey = await _client.createPurchase(randomId);
    _localDataSource.setCartKey(cartKey);
    _localDataSource.setPurchaseKey(purchaseKey);
    return newCart;
  }

  Future<Models.Cart> createCartFromPurchase(
      Map<String, dynamic> response) async {
    final purchase = Models.Purchase.fromJson(response);
    return await _client.createCartFromPurchase(purchase.id);
  }

  @override
  Future<List<Product>> getProducts() async {
    final productsResponse = await _client.getProducts();
    final products =
        productsResponse.map((p) => Models.Product.fromJson(p)).toList();
    return products
        .map(
          (p) => Product(
            id: p.id,
            image: p.image,
            name: p.name,
            description: p.description,
            sku: p.sku,
            price: p.price,
          ),
        )
        .toList();
  }

  @override
  Future<void> updateCart({Cart cart}) async {
    final cartModel = Models.Cart.fromEntity(cart);
    final cartId = _localDataSource.getCartId();
    await _client.updateCart(cartModel, cartId);
  }

  @override
  Future<void> order({int cartId}) async {
    final purchaseId = _localDataSource.getPurchaseId();
    await _client.order(cartId, purchaseId);
    _localDataSource.setCartKey(null);
    _localDataSource.setPurchaseKey(null);
  }
}
