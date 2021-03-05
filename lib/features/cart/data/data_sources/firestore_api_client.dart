import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tul_shoppingcart/features/cart/data/models/models.dart';

class FireStoreApiClient {
  FireStoreApiClient({
    cf.FirebaseFirestore firebaseFireStore,
  }) : _firebaseFireStore = firebaseFireStore ?? cf.FirebaseFirestore.instance;

  final cf.FirebaseFirestore _firebaseFireStore;

  cf.CollectionReference get _products =>
      _firebaseFireStore.collection('products');

  cf.CollectionReference get _purchase =>
      _firebaseFireStore.collection('carts');

  cf.CollectionReference get _carts =>
      _firebaseFireStore.collection('products_carts');

  Future<List<Product>> getProducts() async {
    final productsSnapshot = await _products.get();
    final products =
        productsSnapshot.docs.map((p) => Product.fromJson(p.data())).toList();
    return products;
  }

  Future<Cart> init() async {
    final sp = await SharedPreferences.getInstance();
    final purchaseId = sp.getString('purchase_key');
    final purchaseSnapshot = await _purchase.doc(purchaseId).get();
    if (purchaseSnapshot.exists) {
      final purchase = Purchase.fromJson(purchaseSnapshot.data());
      final cartSnapshot =
          await _carts.where('cart_id', isEqualTo: purchase.id).get();
      return Cart.fromJson(cartSnapshot.docs.last.data());
    }
    final randomId = Random().nextInt(100);
    final newCart = Cart(cartId: randomId, products: []);
    final cart = await _carts.add(newCart.toJson());
    final purchase =
        await _purchase.add(Purchase(id: randomId, status: 'pending').toJson());
    sp.setString('purchase_key', purchase.id);
    sp.setString('cart_key', cart.id);
    return newCart;
  }

  Future<Cart> updateCart(Cart cart) async {
    final sp = await SharedPreferences.getInstance();
    final cartId = sp.getString('cart_key');
    await _carts.doc(cartId).update(cart.toJson());
    return Cart(cartId: cart.cartId, products: cart.products);
  }

  Future<void> order(int cartId) async {
    final sp = await SharedPreferences.getInstance();
    final purchaseId = sp.getString('purchase_key');
    await _purchase
        .doc(purchaseId)
        .update(Purchase(id: cartId, status: 'complete').toJson());
    sp.setString('purchase_key', null);
    sp.setString('cart_key', null);
  }
}
