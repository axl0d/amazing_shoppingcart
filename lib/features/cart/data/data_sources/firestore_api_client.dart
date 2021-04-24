import 'package:amazing_shoppingcart/features/cart/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:injectable/injectable.dart';

@module
abstract class FireStoreApiClientModule {
  @lazySingleton
  cf.FirebaseFirestore get fireStore => cf.FirebaseFirestore.instance;
}

@lazySingleton
class FireStoreApiClient {
  const FireStoreApiClient(
    this._firebaseFireStore,
  );

  final cf.FirebaseFirestore _firebaseFireStore;

  cf.CollectionReference get _products =>
      _firebaseFireStore.collection('products');

  cf.CollectionReference get _purchase =>
      _firebaseFireStore.collection('carts');

  cf.CollectionReference get _carts =>
      _firebaseFireStore.collection('products_carts');

  Future<List<Map<String, dynamic>>> getProducts() async {
    final productsSnapshot = await _products.get();
    final products = productsSnapshot.docs.map((p) => p.data()).toList();
    return products;
  }

  Future<Map<String, dynamic>> getPurchase(String purchaseId) async {
    final purchaseSnapshot = await _purchase.doc(purchaseId).get();
    return purchaseSnapshot.data() ?? {};
  }

  Future<String> createNewCart(Cart newCart) async {
    final cart = await _carts.add(newCart.toJson());
    return cart.id;
  }

  Future<String> createPurchase(int cartId) async {
    final purchase = await _purchase.add(Purchase(
      id: cartId,
      status: 'pending',
    ).toJson());
    return purchase.id;
  }

  Future<Cart> createCartFromPurchase(int purchaseId) async {
    final cartSnapshot = await _carts
        .where(
          'cart_id',
          isEqualTo: purchaseId,
        )
        .get();
    return Cart.fromJson(cartSnapshot.docs.last.data());
  }

  Future<void> updateCart(Cart cart, String cartId) async {
    await _carts.doc(cartId).update(cart.toJson());
  }

  Future<void> order(int cartId, String purchaseId) async {
    await _purchase.doc(purchaseId).update(Purchase(
          id: cartId,
          status: 'complete',
        ).toJson());
  }
}
